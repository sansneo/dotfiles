# dotfiles
> I use the Alpine Linux minimal rootfs on Windows WSL

This is what I am working on right now and it's great!  
You can do everything pretty much anything on Windows with WSL.

## Philosophy
* My toolset must be a small selection of quality tools, each serving a distinct purpose,  
  so I can master all of them over time.
* Limiting that building fatigue while working and lowering overhead is a priority and dictates  
  the selection of these tools.
* Pragmatism, minimalism and modernity(when sensible). I will use what works to get to my goals  
  and I won't adopt something just because it's new and shiny!
* Keeping things as default as possible to limit time wasted configuring things, but I will  
  update stuff now and then if worth it.
* I must be able to use my most important tools over SSH without any issues.

## My awesome toolset
* kernel: linux
* package manager: apk
* userland: busybox
* archiver: atool
* transfer: curl
* hashing/encryption: openssl
* editors: ed, vi and helix
* multiplexer: tmux
* modernity: fd, rg, sk and jq
* shell: zsh
* langs: each takes 6 months to 2 years minimum to truly understand
  * ash(shell scripting)
  * awk(pattern scanning and processing)
  * asm/c(systems programming, clang/llvm toolchain with lldb and make)
  * go(cloud work)
  * node(webdev)
  * elixir(functional)
  * sqlite(local database)
  * typst(typesetting)
* hacking: strace, ltrace and rizin
* vcs: git(with github-cli)
* wiki: markdown oxide
* remote: openssh
* backups: rsync and rclone
* containers: docker and kubernetes
* infrastructure: aws, azure, tencent, terraform and polumi
* init: openrc
* libc: musl

Use [manned.org](https://manned.org/) to access manual pages.

### Windows
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

3. Switch to the edge repositories, update and upgrade
```sh
echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" > /etc/apk/repositories
echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
apk update
apk upgrade
```

4. Install Busybox OpenRC and the Busybox SUID
```sh
apk add busybox-suid busybox-openrc busybox-extras busybox-extras-openrc
```

5. Get `zsh`, add a standard user and assign groups
```sh
apk add zsh
adduser -h /home/sans -s /bin/zsh sans
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

2. Install rest of the toolset
```sh
doas apk add \
  atool 7zip \
  curl openssl openssh \
  file ed helix helix-tree-sitter-vendor \
  tmux markdown-oxide\
  ripgrep fd skim jq \
  strace ltrace rizin \
  rsync rclone
```
```sh
# C on LLVM  
doas apk add llvm lldb clang21 clang21-analyzer clang21-extra-tools make
```
```sh
# Go
doas apk add go delve golangci-lint
go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest
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

3. Docker
```sh
doas apk add docker-engine docker-cli docker-cli-buildx docker-cli-compose docker-openrc
doas rc-update add containerd default
doas rc-update add docker default
doas adduser sans docker
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

## Authoritative documentation links
* [Alpine Linux](https://alpinelinux.org)
* [Linux](https://www.kernel.org)
* [Busybox](https://busybox.net)
* [Curl](https://curl.se)
* [Helix](https://helix-editor.com)
* [Tmux](https://tmux.github.io)
* [LLVM](https://llvm.org)
* [GNU Make](https://www.gnu.org/software/make)
* [Go](https://go.dev)
* [JavaScript](https://tc39.es)
* [TypeScript](https://www.typescriptlang.org)
* [NodeJS](https://nodejs.org)
* [Elixir](https://elixir-lang.org)
* [Sqlite](https://sqlite.org)
* [Typst](https://typst.app)
* [Rizin](https://rizin.re)
* [Git](https://git-scm.com/docs)
* [GitHub](https://docs.github.com)
* [Markdown Oxide](https://oxide.md)
* [OpenSSH](https://www.openssh.com)
* [Docker](https://docs.docker.com)
* [Kubernetes](https://kubernetes.io)
* [AWS](https://docs.aws.amazon.com)
* [Azure](https://learn.microsoft.com/en-us/azure)
* [Tencent](https://www.tencentcloud.com/document/product)
* [HashiCorp](https://developer.hashicorp.com)
* [Polumi](https://www.pulumi.com)

## Conclusion
This is made by myself for myself.  
Clone disks instead of reinstalling if you can as this takes like an hour to do.  
Remember to sync stuff with an in `crontab -e` and Google Drive!
