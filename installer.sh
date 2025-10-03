#!/bin/sh

# Are you root?
if [ "$(id -u)" -ne 0 ]; then
    echo "Run as root!"
    exit 1
fi

# Creating directories
mkdir -pv /home/sans/git/forks /home/sans/lsp

# Update repositories first
echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" > /etc/apk/repositories
echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
apk update
apk upgrade

# Installing all packages
apk add --no-cache \
  7zip \
  atool \
  busybox-extras \
  busybox-extras-openrc \
  busybox-openrc \
  busybox-suid \
  croc \
  curl \
  ed \
  fd \
  file \
  git \
  git-lfs \
  git-lfs-zsh-completion \
  git-zsh-completion \
  github-cli \
  github-cli-zsh-completion \
  helix \
  helix-tree-sitter-vendor \
  jq \
  make \
  ncurses \
  openssh-client \
  openssl \
  patch \
  pcre \
  rclone \
  ripgrep \
  rsync \
  skim \
  tmux \
  tmux-zsh-completion \
  which \
  xclip \
  zsh \
  zsh-completions
  
# Services
rc-update add localmount boot
rc-update add bootmisc boot
rc-update add sysctl boot
rc-update add syslog default
rc-update add networking default
rc-update add crond default

# Docker
apk add --no-cache docker-engine docker-cli docker-cli-buildx docker-cli-compose docker-zsh-completion docker-openrc
rc-update add containerd default
rc-update add docker default
adduser sans docker

# Markdown
apk add markdown-oxide
curl -fLO https://github.com/artempyanykh/marksman/releases/latest/download/marksman-linux-x64
mv marksman-linux-x64 "/home/sans/lsp/marksman"

# C
apk add --no-cache build-base gdb llvm clang21 clang21-analyzer clang21-extra-tools lldb
apk add --no-cache strace ltrace rizin

# Go
apk add --no-cache go delve golangci-lint golangci-lint-zsh-completion
doas -u sans go install golang.org/x/tools/gopls@latest
doas -u sans go install golang.org/x/tools/cmd/goimports@latest
doas -u sans go install github.com/pressly/goose/v3/cmd/goose@latest

# NodeJS
apk add --no-cache nodejs npm
npm install -g typescript typescript-language-server

# Elixir
apk add --no-cache elixir
curl -s https://api.github.com/repos/elixir-lsp/elixir-ls/releases/latest | \
grep "browser_download_url.*elixir-ls.*\.zip" | \
cut -d '"' -f 4 | \
xargs curl -fLO
unzip elixir-ls*.zip -d "/home/sans/lsp"
chmod +x "/home/sans/lsp/language_server.sh"
mv "/home/sans/lsp/language_server.sh" "/home/sans/lsp/elixir-ls"
rm elixir-ls*.zip

# Sqlite
apk add --no-cache sqlite

# Typst
apk add --no-cache typst typst-zsh-completion tinymist

# Removing default Helix themes
rm -rf /usr/share/helix/runtime/themes/*

# Fixing permissions
chown sans -R /home/sans
