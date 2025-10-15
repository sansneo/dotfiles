#!/bin/sh

# Lookup
HOME_DIR="${HOME:-}"
DIRS="$HOME_DIR
$HOME_DIR/git
$HOME_DIR/git/forks
$HOME_DIR/notes"

# This uses skim, but any other fuzzy finder will do
if [ $# -eq 1 ]; then
    selected="$1"
else
    selected=$(fd --type=dir --max-depth=1 --absolute-path . $DIRS \
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
tmux switch-client -t "=$session_name"
