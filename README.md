# bootable-ioquake3

A bootable live image for ioquake3-based LAN parties!
Works with Quake III Arena or OpenArena game data.


## Requirements
* Docker
* Game data


## Quick Start:
```
git clone https://github.com/systemj/ioquake3-bootable
cd ioquake3-bootable
cp /your/game/data/*.pk3 files/baseq3
./build-iso.sh
```

## Usage

The resulting ISO file is bootable as a DVD or USB image about 1.2GB in size.  The live system runs entirely from RAM once it starts up, so the same drive can be used to boot multiple computers.  Even copying the image to RAM it can run on a machine with as little as 1.5GB of memory.

To write to a USB drive:
```
dd if=ioquake.yyyy.mm.dd-x86_64.iso bs=1M status=progress of=/dev/sdX
```

Where /dev/sdX is the device for your USB media.

When booting the image, it will go straight into the game if a network connection is detected, or prompt the user to configure the network (via nm-applet) otherwise.

The keyboard audio and screen brightness keys should work as expected, and the volume is reset to 65%/unmute every time the game (really i3) starts.

## Game Data

### Quake III Arena / Team Arena

The game data for Quake III and Team Arena can be obtained from the official installation media or from your existing installation (sometimes in $HOME/.q3a).

Form Quake III copy pak0.pk3 to bootable-ioquake3/files/baseq3 
From Team Arena copy pak0.pak to bootable-ioquake3/files/missionpack

You will also need the patch release files required to play Quake III on the current version of ioquake3.  They can be obtained from the ioquake3 website:

https://ioquake3.org/extras/patch-data/

After agreeing to the EULA and downloading the zip file, extract it and copy the files from the baseq3 and missionpack directories to the same locations as above.

In order not to be prompted to enter your CD KEY each time the game starts, you can include the baseq3/q3key file from your existing installation to bootable-ioquake3/files/baseq3/q3key or create it.  The format is:

```
yourkeygoeshere
// generated by quake, do not modify
// Do not give this file to ANYONE.
// id Software and Activision will NOT ask you to send this file to them.

```

### OpenArena

OpenArena can be downloaded from the official site:
http://www.openarena.ws/download.php

Download the OpenArena v0.8.8 Win/Lin/Mac Unified and OpenArena v0.8.8 patch zip files.

Extract the files and copy the .pk3 files from the baseoa directories to files/baseq3

## Additional Info

The bootable image is based on the Arch Linux install media live image, and created using the archiso tools, inspired by this gist:
https://gist.github.com/satreix/c01fd1cb5168e539404b

The root and quake3 users do not have passwords, and a console logged in as root is available on tty1 (reachable via alt-ctrl-f1) if needed for troubleshooting or customization.  In the i3 window manager (seen if prompted to configure networking), additional terminals can be launched by pressing win+enter, and additional workspaces can be accessed by pressing win+# (default i3 keybindings with win key).

Quitting the game will simply cycle back to starting the game again; pressing the power key should cause the system to shutdown gracefully.

## Related Links

https://ioquake3.org/
http://www.openarena.ws
https://wiki.archlinux.org/index.php/archiso
