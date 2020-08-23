#!/bin/bash

docker run -d --user $(id -u):$(id -g) --rm -it -e HOME \
  -e DISPLAY=unix:0 -e XAUTHORITY=/tmp/xauth \
  -v $XAUTHORITY:/tmp/xauth -v $HOME:$HOME \
  -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro \
  -v /tmp/.X11-unix:/tmp/.X11-unix --privileged --network=host -w $HOME armhzjz/signal-in-docker:latest

