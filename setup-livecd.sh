#!/bin/bash

# setup livecd directory
mkdir ./livecd
cp -r /usr/share/archiso/configs/releng/* ./livecd 

# update packaged installed in the live environment
cat >> ./livecd/packages.x86_64 << EOF
xorg-xbacklight
unzip
slim
xf86-video-amdgpu
xf86-video-ati
xf86-video-dummy
xf86-video-fbdev
xf86-video-intel
xf86-video-nouveau
xf86-video-openchrome
xf86-video-sisusb
xf86-video-vesa
xf86-video-vmware
xf86-video-voodoo
xf86-video-qxl
xf86-input-synaptics
iw
networkmanager
dmenu
sudo
xorg-xinit
xterm
alsa-utils
xorg-xrandr
libepoxy
libgudev
libinput
libwacom
libxfont2
mtdev
xf86-input-libinput
xorg-server-common
xorg-setxkbmap
xorg-xkbcomp
xorg-server
atk
libxcursor
libtiff
jasper
shared-mime-info
gdk-pixbuf2
dconf
libxcomposite
at-spi2-core
at-spi2-atk
libcroco
librsvg
gtk-update-icon-cache
adwaita-icon-theme
json-glib
wayland-protocols
desktop-file-utils
cantarell-fonts
lcms2
libgusb
colord
gsettings-desktop-schemas
glib-networking
libsoup
rest
avahi
libcups
libtool
tdb
sound-theme-freedesktop
libcanberra
gtk3
mobile-broadband-provider-info
iso-codes
gcr
nm-connection-editor
giflib
libid3tag
imlib2
fluxbox
alsa-lib
flac
libsndfile
libsamplerate
fftw
alsa-utils
libpng
graphite
harfbuzz
freetype2
libjpeg-turbo
libogg
libvorbis
openal
opus
opusfile
xcb-proto
xorgproto
libxdmcp
libxau
libxcb
libx11
libxext
libxrender
libpciaccess
libdrm
icu
libxml2
wayland
libxxf86vm
libxfixes
libxdamage
libxshmfence
libomxil-bellagio
libunwind
llvm-libs
lm_sensors
mesa
libglvnd
libxcursor
libibus
sdl2
feh
libexif
libnotify
network-manager-applet
xcb-util-keysyms
xcb-util-wm
libev
yajl
startup-notification
xcb-util-renderutil
xcb-util-image
xcb-util-cursor
xcb-util-xrm
libxkbcommon-x11
i3-gaps
i3blocks
i3lock
confuse
libasyncns
libpulse
i3status
EOF

# boot menu
cp files/syslinux/* ./livecd/syslinux/
cp files/efiboot/* ./livecd/efiboot/loader/entries/

# ioquake3 package
cp files/ioquake3*.tar.xz livecd/airootfs/root/ioquake3.tar.xz

# copy over game data
mkdir -p livecd/airootfs/home/quake3/.q3a/{baseq3,missionpack}
for pk3dir in baseq3 missionpack
  do
  for pk3 in files/${pk3dir}/*.pk3
    do
    ln ${pk3} livecd/airootfs/home/quake3/.q3a/${pk3dir}
  done
done

# cd key
if test -f files/baseq3/q3key ; then
  cp files/baseq3/q3key livecd/airootfs/home/quake3/.q3a/baseq3
fi

# server.cfg
cp files/baseq3/server.cfg livecd/airootfs/home/quake3/.q3a/baseq3

# i3 config
mkdir -p livecd/airootfs/home/quake3/.config/i3
cp files/i3/*  livecd/airootfs/home/quake3/.config/i3

# Network setup message and startup scripts
cp files/startup.sh livecd/airootfs/home/quake3
cp files/network-msg.sh livecd/airootfs/home/quake3
cp files/quake3-server.sh livecd/airootfs/home/quake3

# Update customizations to the live environment
cat >> ./livecd/airootfs/root/customize_airootfs.sh << EOF

# Enable graphical environment on boot
systemctl set-default graphical.target
systemctl enable slim

# enable NetworkManager
systemctl enable NetworkManager

# Enable auto-login for the quake3 user
echo "default_user quake3" >> /etc/slim.conf
echo "auto_login yes" >> /etc/slim.conf

# Create quake3 user account
useradd -d /home/quake3 -s /bin/bash quake3
cp -r /etc/skel/.[^.]* /home/quake3
chown -R quake3. /home/quake3

# full sudo access
echo "quake3 ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/quake3

echo "exec i3" > /home/quake3/.xinitrc

pacman --noconfirm -U /root/ioquake3.tar.xz

EOF

