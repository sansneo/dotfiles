# Installing on Windows WSL
You can do pretty much everything on Windows WSL!

## Windows
1. Get the ISO, make a bootable USB and get it done.  

> [!TIP]
> Disconnect from the internet, press SHIFT+F10 and write OOBE\BYPASSNRO.  
> Then continue with the installation as usual.  
> This skips the required and enforced login to a Microsoft account(also allowing an offline installation).  
> The way you do this might be changing in the future apparently.

2. Run the [necessary debloater](https://github.com/Raphire/Win11Debloat).
3. Install my Windows Terminal `settings.json`.
4. Install Firefox Developer Edition with the Bitwarden, uBlock Origin(add the filters) and YouTube Unhook extensions then import `bookmarks.html`!

> [!NOTE]
> Just use Mozilla sync now.

5. Go over Windows Settings and remember:
  * Automatically hide the Windows Taskbar.
  * Keep animations on, I like them!
  * Tweak Windows Explorer settings.

I basically use Windows Terminal, Visual Studio Code and Firefox 99% of the time and it's super comfy.

> [!TIP]
> Using Helix to code, but Visual Studio Code as my personal wiki.  
> Install the GitHub Theme, Vim and WSL extensions if you wanna try my config!  
> It's really powerful even though right now am I using Helix bindings there as well.

### Alpine
1. Enable the WSL and Virtual Machine Platform features and reboot.
```
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
shutdown.exe /r /t 0
```
2. Install the latest Alpine Linux minimal rootfs on WSL.
```
New-Item -Type Directory $env:USERPROFILE\AlpineWSL
wsl.exe --import AlpineWSL $env:USERPROFILE\AlpineWSL alpine-minirootfs-x86_64.tar
wsl.exe -d AlpineWSL
```

> [!TIP]
> Use `-u` to specify a user as in `wsl.exe -d AlpineWSL -u root`.

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
```
```sh
apk update
apk upgrade
```
> [!WARNING]
> To upgrade to edge you need to use the merge script for now!

4. Install Busybox OpenRC and the Busybox SUID
```sh
apk add busybox-suid busybox-openrc busybox-extras busybox-extras-openrc
```

5. Get `zsh`, add a standard user and assign groups
```sh
apk add zsh ncurses pcre
adduser -h /home/sans -s /bin/sans
adduser sans wheel
adduser sans users
adduser sans audio
adduser sans video
adduser sans input
```

6. Set the root password, get `doas` plus `doas-sudo-shim` and configure them
```sh
passwd
apk add doas doas-sudo-shim
echo 'permit persist keepenv :wheel' > /etc/doas.conf
```

7. Networking
```sh
# Required by /etc/init.d/networking that's needed for Docker
touch /etc/network/interfaces
# Firewall
apk add nftables nftables-openrc
rc-update add nftables boot
# Cron
rc-update add crond default
```

8. Install my `wsl.conf`
```ini
[automount]
enabled = true
mountFsTab = true

[network]
hostname = "computer"

[interop]
enabled = true
appendWindowsPath = false

[user]
default = "sans"

[boot]
command = "/sbin/openrc default"
```

> [!WARNING]
> To have access to the Windows $PATH in WSL you need to modify `/etc/profile` and `wsl.conf`.  
> Make $PATH reassign itself as in `export PATH="$PATH:..."` and set `appendWindowsPath` to `true`!

9. Set the timezone and reboot
```sh
apk add tzdata
ln -s /usr/share/zoneinfo/Europe/Rome /etc/localtime
````

10. Reboot
```
wsl.exe --terminate AlpineWSL
```

> [!TIP]
Use `wsl.exe --shutdown` to shutdown WSL completely affecting all installations.

### Dotfiles
1. Get `git` and clone this repository
```sh
doas apk add git git-lfs github-cli
git clone https://github.com/sansneo/dotfiles
cd dotfiles
```

2. Install the toolset
```sh
doas apk add \
  atool 7zip \
  curl openssh \
  helix helix-tree-sitter-vendor \
  tmux markdown-oxide\
  ripgrep fd skim jq \
  strace ltrace rizin \
  rsync rclone file xclip
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

3. Create missing directories
```sh
# Obviously fill them up afterwards
mkdir -pv ~/git/forks ~/notes ~/life
```

4. Remove default Helix themes
```sh
doas rm -rf /usr/share/helix/runtime/themes
```

5. Making sure permissions are set correctly
```sh
doas chown sans -R /home/sans
```

6. Install the dotfiles where they belong

7. Done! 🎉

> [!NOTE]
> Microcontrollers require additional setup to work in WSL.

