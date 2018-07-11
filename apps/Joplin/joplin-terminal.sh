#!/usr/bin/env sh
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
PROJECT_BASE_PATH="$( cd $SCRIPTPATH/../.. ; pwd -P )"

dockerfile="Dockerfile.Terminal_tpl"
container_name="joplin-terminal"

$PROJECT_BASE_PATH/parse-includes.sh "$(pwd)/$dockerfile"

docker-compose up --no-start --build $container_name
if [ $? != 0 ]; then
  exit 1
fi


#$PROJECT_BASE_PATH/bin/docker-xhost-helper.sh "$container_name"

docker-compose run $container_name $@

