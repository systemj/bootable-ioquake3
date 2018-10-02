#!/bin/bash

# This is executed inside the archimg/base docker image

# Update and install required packages
pacman -Syu --noconfirm
pacman -S --noconfirm gcc libglvnd curl freetype2 libjpeg libvorbis openal opus opusfile sdl2 zlib git mumble autoconf make pkg-config fakeroot make squashfs-tools libisoburn dosfstools patch lynx devtools git squashfs-tools libisoburn dosfstools patch lynx devtools 

# Build and install archiso
git clone git://projects.archlinux.org/archiso.git 
cd archiso 
make install 

# Build the ioquake3-git AUR package
useradd -m -d /home/build -s /bin/bash build
cd /home/build
curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/ioquake3-git.tar.gz 
tar -C /home/build -zxf ioquake3-git.tar.gz
chown -R build /home/build/ioquake3-git
su - -c 'cd ioquake3-git ; makepkg -s' build
cp /home/build/ioquake3-git/ioquake3*.tar.xz /iso/files

# Setup the custom live environment
cd /iso
./setup-livecd.sh

# Replace the default build.sh
cp build.sh ./livecd/build.sh

# Build the bootable image
cd livecd
./build.sh -N ioquake3 -L ioquake3 -A ioquake3 -v

# Copy outout
cp out/*.iso /iso

cd ..
rm -rf livecd
