#!/bin/sh

# Creating projects directory
mkdir /home/sans/git

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
  build-base \
  busybox-extras \
  busybox-extras-openrc \
  busybox-openrc \
  curl \
  ed \
  fd \
  gdb \
  git \
  git-lfs \
  git-lfs-zsh-completion \
  git-zsh-completion \
  github-cli \
  github-cli-zsh-completion \
  helix \
  helix-tree-sitter-vendor \
  jq \
  ltrace \
  markdown-oxide \
  ncurses \
  openssl \
  pcre \
  rclone \
  ripgrep \
  rizin \
  rsync \
  skim \
  sqlite \
  strace \
  tmux \
  tmux-zsh-completion \
  typst \
  typst-zsh-completion \
  xclip \
  zsh \
  zsh-completions
  
# Installing Docker
apk add --no-cache docker-engine docker-cli docker-cli-buildx docker-cli-compose docker-zsh-completion docker-openrc
rc-update add docker default
adduser sans docker

# Installing the marksman LSP and markdown oxide
curl -fLO https://github.com/artempyanykh/marksman/releases/latest/download/marksman-linux-x64
mkdir "/home/sans/marksman"
mv marksman-linux-x64 "/home/sans/marksman/marksman"

# Installing Go LSP and development packages
apk add --no-cache go gopls golangci-lint golangci-lint-zsh-completion delve
go install github.com/pressly/goose/v3/cmd/goose@latest

# Installing NodeJS LSP and development packages
apk add --no-cache nodejs npm
npm install -g typescript-language-server typescript

# Installing Elixir LSP and packages
apk add --no-cache elixir
curl -s https://api.github.com/repos/elixir-lsp/elixir-ls/releases/latest | \
grep "browser_download_url.*elixir-ls.*\.zip" | \
cut -d '"' -f 4 | \
xargs curl -fLO
unzip elixir-ls*.zip -d "/home/sans/elixir"
chmod +x "/home/sans/elixir/language_server.sh"
mv "/home/sans/elixir/language_server.sh" "/home/sans/elixir/elixir-ls"
rm elixir-ls*.zip

# Installing the AWS CLI
apk add --no-cache aws-cli aws-cli-zsh-completion

# Installing ffmpeg and yt-dlp
apk add --no-cache ffmpeg yt-dlp

# Removing Helix themes
rm -rf /usr/share/helix/runtime/themes/*

# Placing the dotfiles
# rsync -av --exclude='.git' --exclude='.gitattributes' .* /home/sans
# mkdir /home/sans/.ssh 2>/dev/null && mv ssh/config /home/sans/.ssh
# mv -f gopls helix scripts /home/sans/.config
# mv -f wsl/wsl.conf /etc

# Fixing permissions
chown sans -R /home/sans
