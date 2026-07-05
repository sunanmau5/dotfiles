#!/bin/bash
# Claude Code statusline
# Reads the JSON payload Claude Code sends on stdin and renders a status line.

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
dir_display=$(basename "$cwd" 2>/dev/null)
[ -z "$dir_display" ] && dir_display="$cwd"

model=$(echo "$input" | jq -r '.model.display_name // .model.id // "unknown"')

in_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
out_tokens=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // 0')

# Git branch / worktree (skip optional locks so this never blocks other git commands)
git_info=""
if [ -n "$cwd" ] && git -C "$cwd" --no-optional-locks rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null)
  worktree=$(echo "$input" | jq -r '.workspace.git_worktree // empty')
  if [ -n "$worktree" ]; then
    git_info="${worktree}:${branch:-detached}"
  else
    git_info="${branch:-detached}"
  fi
fi

# Context usage summary (percentage + used/total tokens)
ctx_line=""
if [ -n "$used_pct" ] && [ "$used_pct" != "null" ] && [ "$ctx_size" -gt 0 ] 2>/dev/null; then
  used_tokens=$(((ctx_size * $(printf '%.0f' "$used_pct")) / 100))
  ctx_line=$(printf "ctx %.0f%% (%dk/%dk)" "$used_pct" "$((used_tokens / 1000))" "$((ctx_size / 1000))")
fi

# PR number + review state for the current branch (if any)
pr_line=""
pr_color=""
if [ -n "$git_info" ] && command -v gh >/dev/null 2>&1; then
  pr_json=$(cd "$cwd" && gh pr view --json number,state,isDraft,reviewDecision 2>/dev/null)
  if [ -n "$pr_json" ]; then
    pr_number=$(echo "$pr_json" | jq -r '.number')
    pr_state=$(echo "$pr_json" | jq -r '.state')
    pr_draft=$(echo "$pr_json" | jq -r '.isDraft')
    pr_review=$(echo "$pr_json" | jq -r '.reviewDecision // empty')

    if [ "$pr_draft" = "true" ]; then
      pr_color='\033[90m' # gray
      pr_status="draft"
    elif [ "$pr_state" = "MERGED" ]; then
      pr_color='\033[35m' # magenta
      pr_status="merged"
    elif [ "$pr_state" = "CLOSED" ]; then
      pr_color='\033[31m' # red
      pr_status="closed"
    else
      case "$pr_review" in
      APPROVED)
        pr_color='\033[32m'
        pr_status="approved"
        ;; # green
      CHANGES_REQUESTED)
        pr_color='\033[31m'
        pr_status="changes requested"
        ;; # red
      *)
        pr_color='\033[33m'
        pr_status="pending review"
        ;; # yellow
      esac
    fi
    pr_line="PR#${pr_number} ${pr_status}"
  fi
fi

# Relative time remaining until the 5-hour rate limit window resets
reset_line=""
resets_at=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
if [ -n "$resets_at" ] && [ "$resets_at" != "null" ]; then
  now=$(date +%s)
  diff=$((resets_at - now))
  if [ "$diff" -gt 0 ]; then
    hours=$((diff / 3600))
    mins=$(((diff % 3600) / 60))
    reset_line="5h reset ${hours}h${mins}m"
  else
    reset_line="5h reset now"
  fi
fi

# Assemble segments, skipping any that are empty. Each segment has a paired
# color; empty color means "use the default dim styling".
segments=("$dir_display")
colors=("")
[ -n "$git_info" ] && segments+=("$git_info") && colors+=("")
segments+=("$model")
colors+=("")
segments+=("$(printf 'in:%s out:%s' "$in_tokens" "$out_tokens")")
colors+=("")
[ -n "$ctx_line" ] && segments+=("$ctx_line") && colors+=("")
[ -n "$pr_line" ] && segments+=("$pr_line") && colors+=("$pr_color")
[ -n "$reset_line" ] && segments+=("$reset_line") && colors+=("")

line=""
for i in "${!segments[@]}"; do
  seg="${segments[$i]}"
  col="${colors[$i]}"
  [ -n "$line" ] && line="${line}\033[2m | \033[0m"
  if [ -n "$col" ]; then
    line="${line}${col}${seg}\033[0m"
  else
    line="${line}\033[2m${seg}\033[0m"
  fi
done

# %b interprets the embedded \033 escapes (works well on both dark and light terminal themes)
printf '%b\n' "$line"
