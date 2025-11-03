#!/bin/sh

cd $(tmux run "echo #{pane_start_path}")
url=$(git remote get-url origin) 

# Opening GitHub repos in $BROWSER
if [[ $url == *github.com* ]]; then
    if [[ $url == git@* ]]; then
        url="${url#git@}"
        url="${url/:/\/}" 
        url="https://$url"
    fi
    "$BROWSER" "$url"
else
    echo "This repository is not hosted on GitHub"
fi
