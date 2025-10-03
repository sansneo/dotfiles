#!/bin/sh

# Create a new window in the life session and run a command
tmux new-window -t life -n "search" -c ~/life "
# Use passed argument as search directory, defaults to $HOME
SEARCH_DIR='${1:-$HOME}'
# Fuzzy finds in the search directory
SELECTED_FILE=\$(fd --type f --hidden . \"\$SEARCH_DIR\" \\
    | sed -e \"s|$HOME/|~/|\" -e \"s|/$||\" \\
    | sk --margin 10% --color \"bw\" \\
    | sed -e \"s|^~/|$HOME/|\")
# Opens the selected file in $EDITOR, fallsback to vi
[ -n \"\$SELECTED_FILE\" ] && ${EDITOR:-vi} \"\$SELECTED_FILE\"
# Kill search window
tmux kill-window -t life:search
"

# Try attaching to the session
tmux switch-client -t life || return 1
