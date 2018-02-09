#!/usr/bin/env bash

image_name="docker-apps-test"
container_name="${image_name}"


function is_image_build {
  [ "$(docker images --filter reference=$container_name --quiet | wc --lines)" != 0 ]
  return $?
}

function build_image {
  docker build --rm --tag $image_name .
}





function is_container_created {
  [ "$(docker ps --filter name=$container_name --all --quiet | wc --lines)" != "0" ]
  return $?
}

function create_container {
  echo "Initializing the new docker container '$container_name' in the background..."

  export DISPLAY=:0
  docker create \
          -it \
	        -P \
          -e DISPLAY \
          -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
          --name $container_name \
          $image_name
}





function is_container_started {
  [ "$(docker ps --filter name=$container_name --quiet | wc --lines)" != "0" ]
  return $?
}

function start_container {
  # Get the container id
  container_id=$(docker ps -a -f name=$container_name -q)
  echo "Container ID is $container_id"

  # Open up the xhost server for the docker instance
  echo "Setting up the local xhost, so that apps from the container can render on the host."
  xhost +local:`docker inspect --format='{{ .Config.Hostname }}' $container_id`

  # Start the container
  echo "Start the container '$container_name' in the background..."
  docker start $container_name 
}





function launch_app {
  docker exec $container_name $@ &
}





if ! is_image_build; then
  build_image
fi

if ! is_container_created; then
  create_container
fi

if ! is_container_started; then
  start_container
fi

launch_app $@
