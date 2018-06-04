# <APPNAME> inside Docker

> Offical description from the app website
>
> ...
Source: [official-app.site](http://www.official-app.site/)


## Usage

This approach is based on Docker Secrets. For this to work you have to enable Docker swarm mode on your host. This can be done with

```sh
docker swarm init
```


Checkout [Swarm Mode - Create a swarm](https://docs.docker.com/engine/swarm/swarm-mode/#create-a-swarm) for more informations.

### Handling secrets

My prefered way of handling credentials is to use Docker secrets. 

```sh
docker secret create <secret-name> /path/to/your/secret.file
```


Reference for official app configuration: [read the docs](http://www.official-app.site/docs).

### Storing the stuff

In all cases I don't like to mount my host filesystem into my containers. You shouldn't either, yust because. Use Docker Volumes instead. So let's create one for <APP-NAME-HERE>:

```sh
docker volume create <volume-name>
```


### Finally fire it up

All should be setup now. Finally run the <APP-NAME-HERE> container / Swarm service with.

```sh
docker service create --name <app-name> \
        --mount type=volume,source=<volume-name>,destination=/home/userless/<mountpoint> \
        --secret source=<secret-name>,target=/home/userless/<secret-mountpoint> \
        bennyli/<app-name>
```


#### Log output

To see what's going on run

```sh
docker service logs -f <app-name>
```


## Advanced informations

### Extend the restart delay

If you use this container in swarm mode (like I described above), the container will automatically restart after one sync with a delay of 5 seconds. This is a sensible default from Docker itself [see the docs](https://docs.docker.com/engine/reference/commandline/service_create/#options). As always, you can change these settings by altering the `docker service create` command. Here is an example to run OfflineIMAP again and again with a delay of 10 minutes.

```sh
docker service create --name <app-name> \
        --mount type=volume,source=<volume-name>,destination=/home/userless/<mountpoint> \
        --secret source=<secret-name>,target=/home/userless/<secret-mountpoint> \
        --restart-condition any \
        --restart-delay 10m \
        bennyli/<app-name>
```

## Contribute

The files for this image are hosted [GitHub](https://github.com/BennyLi/docker-apps/blob/master/apps/<app-name>/).
If you find a bug or like to give a hint for enhancements issue a ticket on [GitHub](https://github.com/BennyLi/docker-apps/issues).

Nothing fits your needs? You just want to give me some love and support what I'm doing? [PayPal Me](https://paypal.me/BennyLi)
