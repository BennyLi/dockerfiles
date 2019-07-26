# Example of sending desktop notifications from a Docker container

This is a simple container for sending notifications. It's should only serve as an example.

## Usage

To send notifications from a docker container to the host system you need to mount the `DBUS_SESSION_BUS_ADDRESS` environment variable and mount the path given by the variable to the container. The process inside the container has to be run under the same user id as the notification deamon on the host system is running. This results in the following command:

```
docker run -it --rm \
        -e DBUS_SESSION_BUS_ADDRESS \
        -v "$(echo $DBUS_SESSION_BUS_ADDRESS | cut -d= -f2):$(echo $DBUS_SESSION_BUS_ADDRESS | cut -d= -f2)" \
        -u $(id -u) \
        bennyli/notifications-test "A notification from a docker container 🎉"
```

## Contribute

The files for this image are hosted [GitHub](https://github.com/BennyLi/docker-apps/blob/master/apps/offlineimap/).
If you find a bug or like to give a hint for enhancements issue a ticket on [GitHub](https://github.com/BennyLi/docker-apps/issues).

Nothing fits your needs? You just want to give me some love and support what I'm doing? [PayPal Me](https://paypal.me/BennyLi)

