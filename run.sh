#!/bin/bash

cd "$(dirname "$0")" || exit 1

mkdir -p $HOME/something/.chrome
mkdir -p $HOME/something/chrome_downloads

docker run -it --rm \
  --security-opt seccomp=$PWD/chrome-seccomp.js \
  --memory 1gb \
  -v /etc/localtime:/etc/localtime:ro \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /dev/shm:/dev/shm \
  -e DISPLAY \
  -v $HOME/something/.chrome:/data \
  -v $HOME/something/chrome_downloads:/user/Downloads \
  --device /dev/dri \
  dustywilson/chrome
