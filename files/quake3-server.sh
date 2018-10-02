#!/bin/sh
#http://wiki.ioquake3.org/Sys_Admin_Guide
/opt/quake3/ioq3ded +set dedicated 1 +exec server.cfg +set com_hunkMegs 128 "$@"

