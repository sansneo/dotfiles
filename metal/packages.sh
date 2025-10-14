#!/bin/sh

# This scripts installs additional software for a Primeagen workflow on bare metal.
# Just in case for whatever reason Windows starts being problematic!

# Drivers(AMD CPU and GPU)
apk add efibootmgr os-prober \
  exfatprogs e2fsprogs ntfs-3g \
  amd-ucode linux-firmware linux-headers \
  mesa-dri-gallium mesa-va-gallium mesa-vdpau-gallium \
  mesa-vulkan-ati vulkan-loader \
  gstreamer gstreamer-vaapi
  
# Services
apk add dbus dbus-openrc \
  elogind elogind-openrc \
  tlp tlp-openrc 

# Xorg(minimal installation with selected utilities)
apk add xorg-server xinit xrandr \
  setxkbmap xset xinput xclip xprop \
  xdg-user-dirs

# Fonts
apk add font-noto font-noto-cjk font-noto-emoji \
  font-commit-mono font-liberation font-jetbrains-mono font-mononoki

# Audio
apk add alsa-firmware sof-firmware \
  pulseaudio pulseaudio-openrc

# Bluetooth
apk add bluez-firmware \
  bluez bluez-openrc

# Programs
apk add \
  alacritty \
  dk sxhkd \
  dmenu scrot \
  nsxiv xwallpaper \
  mpv obs-studio \
  zathura zathura-pdf-mupdf zathura-cb \
  code-oss firefox-developer-edition qbittorrent
