#! /usr/bin/env sh

DOCKERFILE="Dockerfile"
DOCKER_CONTEXT="$(docker context ls | grep '*' | cut -d ' ' -f 1)"

if [ "$DOCKER_CONTEXT" == "rootless" ]; then
  DOCKERFILE="Dockerfile.rootlesshost"
fi

echo "[INFO]  Docker context is   $DOCKER_CONTEXT"
echo "[INFO]  Using Dockerfile    $DOCKERFILE"

docker build                             \
         --tag bennyli/rangerfm          \
         --build-arg USER_ID=$(id -u)    \
         --build-arg GROUP_ID=$(id -g)   \
         --file "$DOCKERFILE"            \
         .
