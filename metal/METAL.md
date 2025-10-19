# Installing on bare metal
This is awesome.

## Alpine Linux
1. Get the ISO, make a bootable USB and boot it up.
2. Run `setup-alpine`, if you are [dual booting](https://wiki.alpinelinux.org/wiki/Dualbooting) then partition and run `setup-disk`!

> [!TIP]
> I like `gptfdisk` for partitioning!

3. Get `openssl` and switch to the [edge repositories](https://wiki.alpinelinux.org/wiki/Repositories), update and upgrade.
```sh
apk add openssl
```
```sh
# Amsterdam
echo "https://eu.edge.kernel.org/alpine/edge/main" > /etc/apk/repositories
echo "https://eu.edge.kernel.org/alpine/edge/community" >> /etc/apk/repositories
# Japan
echo "https://ap.edge.kernel.org/alpine/edge/main" >> /etc/apk/repositories
echo "https://ap.edge.kernel.org/alpine/edge/community" >> /etc/apk/repositories
# CDN
echo "https://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories
echo "https://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
```sh
apk update
apk upgrade
```
> [!WARNING]
> To upgrade to edge you need to use the merge script for now!

4. Install Busybox OpenRC.
```sh
apk add busybox-suid busybox-openrc busybox-extras busybox-extras-openrc
```

5. Get `zsh`, add a standard user and assign groups.
```sh
apk add zsh ncurses pcre
adduser -h /home/sans -s /bin/zsh
adduser sans wheel
adduser sans users
adduser sans audio
adduser sans video
adduser sans input
adduser sans floppy
adduser sans games
```

6. Set the root password, get `doas` plus `doas-sudo-shim` and configure them.
```sh
passwd
apk add doas doas-sudo-shim
echo 'permit persist keepenv :wheel' > /etc/doas.conf
```

7. Enable services.
```sh
# Cron
rc-update add crond default
# Firewall
apk add nftables nftables-openrc
rc-update add nftables boot
# Dbus
apk add dbus dbus-x11 dbus-openrc
rc-update add dbus default
# Elogind
apk add elogind util-login-linux elogind-openrc
rc-update add elogind
# Polkit
apk add polkit polkit-openrc
rc-update add polkit
# TLP
apk add tlp tlp-openrc
rc-update add tlp
```

8. Reboot.
```sh
reboot
```

9. Get the drivers!
```sh
# Drivers(AMD CPU and GPU)
doas apk add efibootmgr os-prober \
  exfatprogs e2fsprogs ntfs-3g \
  amd-ucode linux-firmware linux-headers \
  mesa-va-gallium mesa-vdpau-gallium \
  mesa-vulkan-ati vulkan-loader \
  gstreamer gstreamer-vaapi
```

9. Install the toolset.
```sh
doas doas apk add \
  atool 7zip \
  curl openssh \
  ed helix helix-tree-sitter-vendor \
  tmux markdown-oxide\
  ripgrep fd skim jq \
  strace ltrace rizin \
  rsync rclone file
```
```sh
# C on LLVM  
doas apk add llvm lldb clang21 clang21-analyzer clang21-extra-tools make
```
```sh
# Go
doas apk add go delve golangci-lint
go install golang.org/x/tools/cmd/goimports@latest
go install golang.org/x/tools/gopls@latest
go install golang.org/x/pkgsite/cmd/pkgsite@latest
go install golang.org/x/vuln/cmd/govulncheck@latest
go install github.com/pressly/goose/v3/cmd/goose@latest
```
```sh
# Javascript/Typescript on NodeJS
doas apk add nodejs npm
doas npm install -g typescript typescript-language-server
```
```sh
# Elixir
doas apk add elixir
```
```sh
# Sqlite
doas apk add sqlite
```
```sh
# Typst
doas apk add typst tinymist
```
```sh
# Docker
doas apk add docker-engine docker-cli docker-cli-buildx docker-cli-compose docker-openrc
doas rc-update add containerd default
doas rc-update add docker default
doas adduser sans docker
```

> [!TIP]
> Proceed for a graphical installation or stop here.

11. Install the rest of the toolset
```sh
# Xorg(minimal installation with selected utilities)
doas setup-xorg-base
doas apk add setxkbmap xclip xdg-user-dirs xinput xprop xrandr xset
```
```sh
# Fonts
doas apk add font-noto font-noto-cjk font-noto-emoji
doas apk add font-commit-mono font-liberation font-jetbrains-mono font-mononoki
```
```sh
# Audio
doas apk add sof-firmware pulseaudio pulseaudio-utils pulseaudio-alsa pulseaudio-bluez pulseaudio-openrc
doas apk add pavucontrol
doas adduser sans pulse
```
```sh
# Bluetooth
doas apk add bluez-firmware bluez bluez-openrc
doas apk blueman
doas rc-update add bluetooth boot
```

15. Toolset(X11)
```sh
doas apk add \
  alacritty \
  dk sxhkd \
  dmenu scrot \
  nsxiv xwallpaper \
  mpv obs-studio \
  zathura zathura-pdf-mupdf zathura-cb \
  code-oss \
  signal-desktop \
  firefox-developer-edition qbittorrent
```

16. Create missing directories!
```sh
# Obviously fill them up afterwards
mkdir -pv ~/git/forks ~/notes ~/life
mkdir -pv ~/downloads ~/documents ~/audios ~/pictures/screenshots ~/videos
```

17. Remove default Helix themes.
```sh
doas rm -rf /usr/share/helix/runtime/themes
```

18. Ensure correct permissions are set.
```
doas chown sans -R /home/sans
```

19. Get `git` and clone this repository
```sh
doas apk add git git-lfs github-cli
git clone https://github.com/sansneo/dotfiles
cd dotfiles
```

20. Install the dotfiles where they belong.

21. Done! 🎉

## Flatpak
Don't love the idea, but they are great!
```sh
# Set it up
doas apk add flatpak
doas flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
doas adduser sans flatpak
# Get the applications
doas flatpak install flathub com.heroicgameslauncher.hgl
doas flatpak install flathub com.rustdesk.RustDesk
doas flatpak install flathub org.kde.krita
doas flatpak install flathub org.kde.kdenlive
doas flatpak install flathub com.google.AndroidStudio
```
> [!TIP]
> Get `xone-src` and run `xone-get-firmware.sh` to use an Xbox One controller.
