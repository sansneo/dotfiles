# Alpine Linux on Windows WSL
> From the latest Alpine Linux mininal rootfs

This is what I am working on right now and it's great!  
Minimal enough to be understood if you wish to do so, yet pragmatic.  
You can do everything pretty much anything on a Windows 11 + WSL system.  

## Steps
1. Install Windows 11!  
Get the ISO, make a bootable USB and get it done.  
> [!TIP]
> Press shift+F10 and write OOBE\BYPASSNRO then continue with the installation without an internet connection
> to skip logging into a Microsoft account  
2. Install Thorium(or whatever browser you use) and the Bitwarden, YouTube Unhook and CouponBirds extensions
3. Enabling the WSL feature and rebooting
```
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
shutdown.exe /r /t 0
```
4. Installing the latest Alpine Linux minimal rootfs in WSL
```
New-Item -Type Directory $env:USERPROFILE\AlpineWSL
wsl.exe --import $env:USERPROFILE\AlpineWSL alpine-minirootfs-x86_64.tar
```
5. Adding a standard user and installing ZSH
```
apk add zsh
adduser -h /home/sans -s /bin/zsh sans -
su -l root
```
6. Installing doas and setting the su SUID bit
```
apk add doas
echo 'permit :wheel' > /etc/doas.d/doas.conf
adduser sans wheel
chmod u+s /bin/su
```
7. Running the installation script
```
su -l sans
doas sh dotfiles/windows/install.sh
```
8. Place the dotfiles in their corrisponding directories
9. Done! 🎉

> [!NOTE]
> Setup mdev and hwdrivers for microcontrollers and more to work.  
> I use Helix for everything, but I do like to keep Codium(optimized and private VSCode fork) installed
> I also have my old setup on a window manager for xorg in `./xorg`!

> [!TIP]
> I have a really cool VSCode configuration with Vim keybindigs I don't use anymore, check it out if you do!
> Get the GitHub Theme, Vim and WSL extensions if you want to try it.
