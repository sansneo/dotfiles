#!/bin/sh

# Lookup
HOME_DIR="${HOME:-}"
DIRS="$HOME_DIR
$HOME_DIR/git
$HOME_DIR/git/forks"

# This uses skim, but any other fuzzy finder will do
if [ $# -eq 1 ]; then
    selected="$1"
else
    selected=$(for dir in $DIRS; do find "$dir" -type d -maxdepth 1 ! -path "$dir" ! -name ".*" 2>/dev/null ; done \
        | sed -e "s|$HOME_DIR/||" -e 's|/$||' \
        | sk --margin 10% --color="bw")
fi

[ -z "$selected" ] && exit 0

# Extracting the basename to use it as the session name
session_name=$(basename "$selected")

# Does the selected session exist?
if ! tmux has-session -t "=$session_name" 2>/dev/null; then
    tmux new-session -ds "$session_name" -c "$HOME_DIR/$selected"
    tmux select-window -t "$session_name:1"
fi

# Switching to the selected session
if [ -n "$TMUX" ]; then
    tmux switch-client -t "=$session_name"
else
    tmux attach-session -t "=$session_name"
fi
