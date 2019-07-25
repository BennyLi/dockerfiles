#! /usr/bin/env sh

if [ -n "$TZ" ];
then
  export TZ="Europe/Berlin"
fi

# Setup the timezone
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
echo $TZ > /etc/timezone

# Start the client
/matterhorn/matterhorn
