#!/bin/sh

# Lookup
HOME_DIR="${HOME:-}"
DIRS="$HOME_DIR
$HOME_DIR/git"

# This uses skim, but any other fuzzy finder will do
if [ $# -eq 1 ]; then
    selected="$1"
else
    selected=$(fd --type=dir --max-depth=1 --absolute-path . $DIRS \
        | sed -e "s|$HOME_DIR/||" -e 's|/$||' \
        | sk --margin 10% --color="bw")
fi

[ -z "$selected" ] && exit 0

# Does the selected session exists?
if ! tmux has-session -t "$selected" 2>/dev/null; then
    tmux new-session -ds "$selected" -c "$HOME_DIR/$selected"
    tmux select-window -t "$selected:1"
fi

# Switching to the selected session
tmux switch-client -t "$selected"
