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

# Human-readable token counts: 1500 -> 1.5k, 2000000 -> 2m
fmt_num() {
  local n=$1
  if [ "$n" -ge 1000000 ]; then
    awk -v n="$n" 'BEGIN { printf "%.1fm", n / 1000000 }'
  elif [ "$n" -ge 1000 ]; then
    awk -v n="$n" 'BEGIN { printf "%.1fk", n / 1000 }'
  else
    printf '%d' "$n"
  fi
}

# Context usage summary (bar + percentage + used/total tokens)
ctx_line=""
if [ -n "$used_pct" ] && [ "$used_pct" != "null" ] && [ "$ctx_size" -gt 0 ] 2>/dev/null; then
  used_tokens=$(((ctx_size * $(printf '%.0f' "$used_pct")) / 100))
  pct_rounded=$(printf '%.0f' "$used_pct")
  bar_width=10
  filled=$(( (pct_rounded * bar_width + 50) / 100 ))
  [ "$filled" -eq 0 ] && [ "$pct_rounded" -gt 0 ] && filled=1
  [ "$filled" -gt "$bar_width" ] && filled="$bar_width"
  empty=$((bar_width - filled))
  bar=$(printf '%*s' "$filled" '' | tr ' ' '█')$(printf '%*s' "$empty" '' | tr ' ' '░')
  ctx_line=$(printf "ctx [%s] %s%% (%s/%s)" "$bar" "$pct_rounded" "$(fmt_num "$used_tokens")" "$(fmt_num "$ctx_size")")
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
segments+=("$(printf 'in:%s out:%s' "$(fmt_num "$in_tokens")" "$(fmt_num "$out_tokens")")")
colors+=("")
[ -n "$ctx_line" ] && segments+=("$ctx_line") && colors+=("")
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
