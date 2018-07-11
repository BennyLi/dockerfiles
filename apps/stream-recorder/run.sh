#! /usr/bin/env sh

docker service rm stream-recorder

docker service create \
  -t \
  -e DISPLAY=$DISPLAY \
  --mount type=bind,source=/tmp/.X11-unix,destination=/tmp/.X11-unix \
  --mount type=bind,source=/home/bln/Video/docker-recording,destination=/home/dev/recordings \
  --secret source=amazon_user,target=/home/dev/amazon_user \
  --secret source=amazon_password,target=/home/dev/amazon_password \
  --restart-condition none \
  --detach \
  --name stream-recorder \
  bennyli/stream-recorder

echo "Attaching to logs"
echo "Press Ctrl-c to detach"
echo ""
docker service logs -f --raw stream-recorder
