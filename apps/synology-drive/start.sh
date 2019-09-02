#! /bin/sh

container_name="synology-drive-client"
config_volume_name="synology-drive-client-config"

if [ -n "$(docker ps -a -f name=$container_name -q)" ]
then
  docker stop "$container_name" > /dev/null
  docker rm "$container_name" > /dev/null
fi


#####  ---------------  Volume Setup  ---------------  #####
if [ -n "$(docker volume ls -f name=$config_volume_name -q)" ]
then
  docker volume create "$config_volume_name" > /dev/null
fi

docker create --tty \
              --name "$container_name" \
              `# Open up the Display for the GUI` \
              -e "DISPLAY=unix$DISPLAY" \
              -v /tmp/.X11-unix:/tmp/.X11-unix \
              `# Mount the config and the documents folder` \
              -v $config_volume_name:/home/dockuser/.SynologyDrive:rw \
              -v $HOME/Documents:/home/dockuser/Documents:rw \
              bennyli/synology-drive-client


container_id=$(docker ps -a -f name=$container_name -q)
xhost +local:`docker inspect --format='{{ .Config.Hostname }}' $container_id`
docker start $container_id
