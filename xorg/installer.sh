#!/bin/sh

# Removing unwanted vim colorschemes and setting murphy as the default
VIM_VERSION=$(vim --version | grep -oP 'Vi IMproved \K[0-9.]+' | tr -d '.')
COLORS_PATH="/usr/share/vim/vim${VIM_VERSION}/colors"
rm \
"$COLORS_PATH/darkblue.vim" \
    "$COLORS_PATH/desert.vim" \
    "$COLORS_PATH/elflord.vim" \
    "$COLORS_PATH/evening.vim" \
    "$COLORS_PATH/koehler.vim" \
    "$COLORS_PATH/morning.vim" \
    "$COLORS_PATH/pablo.vim" \
    "$COLORS_PATH/retrobox.vim" \
    "$COLORS_PATH/slate.vim" \
    "$COLORS_PATH/torte.vim" \
    "$COLORS_PATH/zellner.vim" \
    "$COLORS_PATH/peachpuff.vim" \
    "$COLORS_PATH/unokai.vim"
mv "$COLORS_PATH/murphy.vim" "$COLORS_PATH/default.vim"

# Installing packages
xbps-install -Syu \
    alacritty \
    blueman \
    cutter \
    dk \
    dmenu \
    mpv \
    go \
    gopls \
    golangci-lint \
    delve \
    nodejs \
    elixir \
    nsxiv \
    obs \
    obs-plugin-browser-bin \
    pavucontrol \
    qbittorrent \
    scrot \
    skim \
    sxhkd \
    v4l2loopback
    vim-x11 \
    xwallpaper \
    zathura \
    zathura-cb \
    zathura-pdf-mupdf
