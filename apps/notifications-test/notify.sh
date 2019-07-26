#! /usr/bin/env sh

# Conditions:
# * needs the user dbus session address (export and mount it)
# * needs to be run as the same user as on host
docker run -it --rm \
        -e DBUS_SESSION_BUS_ADDRESS \
        -v "$(echo $DBUS_SESSION_BUS_ADDRESS | cut -d= -f2):$(echo $DBUS_SESSION_BUS_ADDRESS | cut -d= -f2)" \
        -u $(id -u) \
        bennyli/notifications-test "A notification from a docker container 🎉"
