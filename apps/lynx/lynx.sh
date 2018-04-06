#!/usr/bin/env sh

container_name="lynx"

docker-compose up --no-start --build $container_name
if [ $? != 0 ]; then
  exit 1
fi


docker-compose run $container_name $@
