#!/bin/bash

if ip route | grep -q default ; then
  :
else
  xterm -bg black -fg grey -bc -e /home/quake3/network-msg.sh
fi

# default soundcard helper
sound_card="$(aplay -l | sed -n -e 's/^card \([0-9]\):.* Analog .*$/\1/p' | head -1)"

if test -n "${sound_card}" ; then
  sudo tee /etc/asound.conf >/dev/null <<- EOF
	defaults.pcm.card ${sound_card}
	defaults.ctl.card ${sound_card}
	EOF
fi

quake3
exit 0
