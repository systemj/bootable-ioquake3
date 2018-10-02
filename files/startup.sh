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

# Run a server instance in addition to the client
if grep "run-q3server" /proc/cmdline ; then
  xterm -bg black -fg grey -bc -e /home/quake3/quake3-server.sh &
  sleep 3
  while pgrep ioq3ded >/dev/null
    do
    quake3
  done
else
  # default mode (client only)
  quake3
fi

exit 0
