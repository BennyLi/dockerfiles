docker run -it --rm \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           -e DISPLAY=unix$DISPLAY \
           -v $(pwd):/root/.wine/drive_c/users/root/Application\ Data/AVM:rw \
           --name fritz-fernzugang \
          bennyli/fritz-fernzugang
