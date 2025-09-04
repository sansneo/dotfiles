#!/bin/bash

# Lookup
DIRS=(
    "$HOME"
    "$HOME/git"
)

# This uses skim, but any other fuzzy finder will do
if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(fd --type=dir --max-depth=1 --absolute-path . "${DIRS[@]}" \
        | sed -e "s|$HOME/||g" | sed 's|/$||' \
        | sk --margin 10% --color="bw")
fi
[[ ! $selected ]] && exit 0

# Does the selected session exists?
if ! tmux has-session -t "$selected"; then
    tmux new-session -ds "$selected" -c "$HOME/$selected"
    tmux select-window -t "$selected:1"
fi

# Switching to the selected session
tmux switch-client -t "$selected"
