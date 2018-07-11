#!/usr/bin/env sh

docker run -it --rm \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -e DISPLAY=unix$DISPLAY \
  bennyli/boostnote
