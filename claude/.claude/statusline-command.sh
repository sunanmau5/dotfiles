#!/bin/bash
# Claude Code statusline
# Reads the JSON payload Claude Code sends on stdin and renders a status line.

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
dir_display=$(basename "$cwd" 2>/dev/null)
[ -z "$dir_display" ] && dir_display="$cwd"

model=$(echo "$input" | jq -r '.model.display_name // .model.id // "unknown"')

in_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
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

# Context usage summary (bar + percentage + used/total tokens).
# total_input_tokens is exactly what used_percentage is derived from, so use it
# directly rather than re-deriving it from the rounded percentage.
ctx_line=""
if [ -n "$used_pct" ] && [ "$used_pct" != "null" ] && [ "$ctx_size" -gt 0 ] 2>/dev/null; then
  used_tokens=$in_tokens
  pct_rounded=$(printf '%.0f' "$used_pct")
  bar_width=10
  filled=$(( (pct_rounded * bar_width + 50) / 100 ))
  [ "$filled" -eq 0 ] && [ "$pct_rounded" -gt 0 ] && filled=1
  [ "$filled" -gt "$bar_width" ] && filled="$bar_width"
  empty=$((bar_width - filled))
  bar=$(printf '%*s' "$filled" '' | tr ' ' '█')$(printf '%*s' "$empty" '' | tr ' ' '░')
  ctx_line=$(printf "ctx [%s] %s%% (%s/%s)" "$bar" "$pct_rounded" "$(fmt_num "$used_tokens")" "$(fmt_num "$ctx_size")")
fi

# Cost-shaped split of the context: tokens processed anew this turn, billed at
# 1x or more (fresh input plus cache writes), versus tokens served from cache at
# ~0.1x. current_usage is null before the first API call and after /compact.
usage_line=""
if [ "$(echo "$input" | jq -r '(.context_window.current_usage // null) != null')" = "true" ]; then
  read -r fresh_tokens cached_tokens <<<"$(echo "$input" | jq -r '.context_window.current_usage
    | "\((.input_tokens // 0) + (.cache_creation_input_tokens // 0)) \(.cache_read_input_tokens // 0)"')"
  usage_line=$(printf 'fresh:%s cache:%s' "$(fmt_num "$fresh_tokens")" "$(fmt_num "$cached_tokens")")
fi

# Estimated cost of this session (client-side estimate; resets on /clear)
cost_line=""
cost_usd=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')
if [ -n "$cost_usd" ] && [ "$cost_usd" != "null" ]; then
  cost_line=$(awk -v c="$cost_usd" 'BEGIN { printf "$%.2f", c }')
fi

# Relative time until a Unix epoch: "3d4h" past a day, otherwise "1h5m"
fmt_until() {
  local diff=$(($1 - $(date +%s)))
  if [ "$diff" -le 0 ]; then
    printf 'now'
  elif [ "$diff" -ge 86400 ]; then
    printf '%dd%dh' $((diff / 86400)) $(((diff % 86400) / 3600))
  else
    printf '%dh%dm' $((diff / 3600)) $(((diff % 3600) / 60))
  fi
}

# One rate-limit window as "<label> <pct>% <time to reset>". Either half may be
# missing: plans that don't report rate limits yield an empty segment.
fmt_window() {
  local label=$1 key=$2 pct resets out
  pct=$(echo "$input" | jq -r ".rate_limits.${key}.used_percentage // empty")
  resets=$(echo "$input" | jq -r ".rate_limits.${key}.resets_at // empty")
  [ -z "$pct" ] && [ -z "$resets" ] && return
  out="$label"
  [ -n "$pct" ] && out="${out} $(printf '%.0f' "$pct")%"
  [ -n "$resets" ] && out="${out} $(fmt_until "$resets")"
  printf '%s' "$out"
}

hour_line=$(fmt_window "5h" "five_hour")
week_line=$(fmt_window "7d" "seven_day")

# Join non-empty segments with a dim pipe, and print only if something remains.
# %b interprets the embedded \033 escapes (readable on dark and light themes).
render_line() {
  local out="" seg
  for seg in "$@"; do
    [ -z "$seg" ] && continue
    [ -n "$out" ] && out="${out}\033[2m | \033[0m"
    out="${out}\033[2m${seg}\033[0m"
  done
  if [ -n "$out" ]; then
    printf '%b\n' "$out"
  fi
}

# Line 1: where you are. Line 2: everything that moves.
render_line "$dir_display" "$git_info" "$model"
render_line "$ctx_line" "$usage_line" "$cost_line" "$hour_line" "$week_line"
