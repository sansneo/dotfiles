# dotfiles
> I use the Alpine Linux extended edition on bare metal or the minimal rootfs in Windows WSL

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
* shell: zsh(with completions)
* langs: each takes 6 months to 2 years minimum to truly understand
  * ash(shell scripting)
  * awk(pattern scanning and processing)
  * asm/c(systems programming, gnu toolchain with gdb and make)
  * go(cloud work)
  * node(webdev)
  * elixir(functional)
  * sqlite(local database)
  * typst(typesettings)
* hacking: strace, ltrace and rizin
* vcs: git(with github-cli)
* wiki: marksman and markdown oxide
* remote: openssh and croc
* backup: rsync and rclone
* containers: docker and kubernetes
* infrastructure: aws, azure, tencent, terraform and polumi
* init: openrc
* libc: musl

## Steps
1. Install Windows 11!
Get the ISO, make a bootable USB and get it done.  

> [!TIP]
> Disconnect from the internet, press SHIFT+F10 and write OOBE\BYPASSNRO.  
> Then continue with the installation as usual.  
> This skips the required and enforced login to a Microsoft account(also allowing an offline installation).  

2. Run the [debloater](https://github.com/Raphire/Win11Debloat) and use my Windows Terminal `settings.json`.
3. Install Thorium with the Bitwarden, YouTube Unhook and CouponBirds extensions then import the bookmarks!

> [!TIP]
> Remember to automatically hide the Windows taskbar.
> As I basically use Windows Terminal and Thorium 99% of the time it's super comfy!

4. Enable the WSL and Virtual Machine Platform features and reboot.
```
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
shutdown.exe /r /t 0
```
5. Install the latest Alpine Linux minimal rootfs in WSL.
```
New-Item -Type Directory $env:USERPROFILE\AlpineWSL
wsl.exe --import AlpineWSL $env:USERPROFILE\AlpineWSL alpine-minirootfs-x86_64.tar
```

6. Add a standard user and install `zsh`
```
apk add zsh
adduser -h /home/sans -s /bin/zsh sans
su -l root
```
7. Install `doas` and set the `su` SUID bit
```
apk add doas doas-sudo-shim
echo 'permit persist :wheel as root' > /etc/doas.conf
adduser sans wheel
chmod u+s /bin/su
```
8. Clone the repository, install `git` and run the installation script
```
su -l sans
doas apk add git
git clone https://github.com/sansneo/dotfiles
cd dotfiles
doas sh installer.sh
```
9. Restart WSL and set the timezone
```
wsl.exe --terminate AlpineWSL
wsl.exe -d AlpineWSL
doas apk add tzdata
doas ln -s /usr/share/zoneinfo/Europe/Rome /etc/localtime
```
10. Place the dotfiles where they belong[^1] and done! 🎉

> [!NOTE]
> Setup `mdev` and `hwdrivers` for microcontrollers(and some other things) to work in WSL.  
> I use Helix for everything, but I do like to have VSCode installed because I used it for such a long time!  
> Get the GitHub Theme, Vim and WSL extensions if you want to try my config!

[^1]: To have access to the Windows $PATH in WSL you need to modify the $PATH export in /etc/profile by adding the current $PATH value to it like this  
      `export PATH="$PATH:/usr..."`

> [!WARNING]
> This is made for myself obviously!
> If for whatever reason you want to copy me make sure to run the following command and to modify my `.zshrc` or simply make sure to use your username
> instead of mine in both the installation and the dotfiles!  
```sh
rg 'sans' -r "$USER" --files-with-matches | xargs sed -i "s/sans/$USER/g"
```

Remember to sync and backup!  
Always clone disks instead of reinstalling if you can.
