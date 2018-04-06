cd edraw
docker-compose up --no-start --build edraw
if [ $? != 0 ]; then
  exit 1
fi

container_name="edraw"
container_id=$(docker ps -a -f name=$container_name -q)
container_hostname=$(docker inspect --format='{{ .Config.Hostname }}' $container_id)
echo "Adding ${container_hostname} to xhost"
xhost +local:${container_hostname}

docker-compose up edraw
