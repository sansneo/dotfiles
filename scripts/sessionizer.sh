#!/bin/sh

# Lookup
HOME_DIR="${HOME:-}"
DIRS="$HOME_DIR
$HOME_DIR/git"

# This uses skim, but any other fuzzy finder will do
if [ $# -eq 1 ]; then
    selected="$1"
else
    # Use find instead of fd for POSIX compatibility
    selected=$(echo "$DIRS" | while read -r dir; do
        if [ -d "$dir" ]; then
            find "$dir" -type d -maxdepth 1 ! -path "$dir" 2>/dev/null
        fi
    done | while read -r path; do
        # Remove HOME prefix and trailing slashes
        echo "$path" | sed -e "s|$HOME_DIR/||" -e 's|/*$||'
    done | sk --margin 10% --color="bw")
fi

[ -z "$selected" ] && exit 0

# Does the selected session exists?
if ! tmux has-session -t "$selected" 2>/dev/null; then
    tmux new-session -ds "$selected" -c "$HOME_DIR/$selected"
    tmux select-window -t "$selected:1"
fi

# Switching to the selected session
tmux switch-client -t "$selected"
