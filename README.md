# dotfiles
> I use the Alpine Linux extended edition on metal or the minimal rootfs in Windows WSL

This is what I am working on right now and it's great!  
You can do everything pretty much anything on a Windows with WSL.

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
* linux: kernel
* apk: package manager
* busybox: userland
* atool: (un)archiver
* curl: HTTP client
* hashing/encryption: openssl
* editors: ed, vi and helix
* multiplexer: tmux
* modernity: fd, rg, skim and jq
* shell: zsh(with completions)
* langs: each takes 6 months to 2 years minimum to truly understand
  * ash(shell scripting)
  * awk(pattern scanning and processing)
  * asm/c(systems programming, GNU toolchain including GDB)
  * go(cloud work)
  * node(webdev)
  * elixir(functional)
  * sqlite(local database)
  * typst(typesettings)
* hacking: strace, ltrace and rizin
* vcs: git(LFS support, GitHub's CLI)
* wiki: marksman and markdown oxide
* remote: openssh
* backup: rsync and rclone
* containers: docker
* init: openrc
* libc: musl

## Steps
1. Install Windows 11!
Get the ISO, make a bootable USB and get it done.  

> [!TIP]
> Disconnect from the internet, press SHIFT+F10 and write OOBE\BYPASSNRO.  
> Then continue with the installation as usual.  
> This skips the required and enforced login to a Microsoft account(also allowing an offline installation).  

2. Run the [debloater](https://github.com/Raphire/Win11Debloat) and replace the Windows Terminal `settings.json`.
3. Install Thorium with the Bitwarden, YouTube Unhook and CouponBirds extensions and import the bookmarks!
4. Enabling the WSL and Virtual Machine Platform features and reboot.
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

> [!WARNING]
> Hey, are you NOT me? Yes?  
> Then make sure to run the following command and to modify my `.zshrc`  
> or make sure to use your username instead of mine both in the installation and the dotfiles!  
```
rg 'sans' -r "$USER" --files-with-matches | xargs sed -i "s/sans/$USER/g"
```

6. Add a standard user and install `zsh`
```
apk add zsh
adduser -h /home/sans -s /bin/zsh sans
su -l root
```
7. Install `doas` and set the `su` SUID bit
```
apk add doas
echo 'permit :wheel' > /etc/doas.d/doas.conf
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
9. Place the dotfiles where they belong[^1]
10. Done! 🎉

> [!NOTE]
> Setup `mdev` and `hwdrivers` for microcontrollers(and some other things) to work in WSL.  
> I use Helix for everything, but I do like to have Codium(optimized and private VSCode fork) installed because I used it for a long time!  
> Get the GitHub Theme, Vim and WSL extensions if you want to try it!

[^1]: To have access to the Windows $PATH in WSL you need to modify the $PATH export in /etc/profile and add the current $PATH to it like this
      `export PATH="$PATH:/usr..."`
