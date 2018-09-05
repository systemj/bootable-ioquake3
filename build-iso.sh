#!/bin/bash

docker run -i -t -v "$(pwd):/iso" --privileged=true archimg/base /iso/build-all.sh
