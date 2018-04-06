#!/usr/bin/env sh

container_name="$1"
container_id=$(docker ps -a -f name=$container_name -q)
container_hostname=$(docker inspect --format='{{ .Config.Hostname }}' $container_id)
echo "Adding ${container_hostname} to xhost"
xhost +local:${container_hostname}
