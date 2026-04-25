#!/usr/bin/env bash
input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // "Claude"')
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Shorten home directory
cwd="${cwd/#$HOME/~}"

# Build context indicator
ctx_part=""
if [ -n "$used" ]; then
  ctx_part=" ctx:$(printf '%.0f' "$used")%"
fi

printf "\033[1;32m%s\033[0m@\033[1;36m%s\033[0m \033[1;34m%s\033[0m | \033[0;33m%s\033[0m%s" \
  "$(whoami)" "$(hostname -s)" "$cwd" "$model" "$ctx_part"
