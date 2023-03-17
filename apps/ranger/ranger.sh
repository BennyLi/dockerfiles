#! /usr/bin/env sh

HOST_MOUNT="$HOME"
DOCKER_CONTEXT="$(docker context ls | grep '*' | cut -d ' ' -f 1)"

RANGER_CONFIG_DIR="$1"
echo $RANGER_CONFIG_DIR

if [ "$DOCKER_CONTEXT" == "rootless" ]; then
  docker run                                                           \
           -it                                                         \
           --rm                                                        \
           --name="ranger"                                             \
           --hostname="$(cat /etc/hostname)[docker,rootless]"          \
           --volume="$HOME":/home/hostfs:rw                            \
           --volume="${RANGER_CONFIG_DIR}/rc.conf:/root/.config/ranger/rc.conf:ro"     \
           --volume="${RANGER_CONFIG_DIR}/rifle.conf:/root/.config/ranger/rifle.conf:ro"  \
           --volume="${RANGER_CONFIG_DIR}/scope.sh:/root/.config/ranger/scope.sh:ro"   \
           bennyli/rangerfm "/home/hostfs"
else
  docker run                                              \
           -it                                            \
           --rm                                           \
           --hostname="$(cat /etc/hostname)[docker]"      \
           --user=$(id -u):$(id -g)                       \
           --volume="$HOME":/home/dockeruser/hostfs:rw    \
           bennyli/rangerfm
fi
