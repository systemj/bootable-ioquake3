#!/bin/bash

if ip route | grep -q default ; then
  :
else
  xterm -bg black -fg grey -bc -e /home/quake3/network-msg.sh
fi
quake3
exit 0
