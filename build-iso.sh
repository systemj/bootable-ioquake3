#!/bin/bash

# The loop kernel module must be loaded before the container doing the build starts, even with
# --privileged=true set.  This awful hack will cause that to happen (no sudo for modprobe or
# insmod required, only the ability to run docker).  Note this command fails but the second
# container will succeed because the module gets loaded.
docker run -i -t -v "$(pwd):/iso" --privileged=true --rm archimg/base mount -o loop /dev/null /mnt >/dev/null 2>&1

# Run the build inside docker
docker run -i -t -v "$(pwd):/iso" --privileged=true --rm archimg/base /iso/build-all.sh
