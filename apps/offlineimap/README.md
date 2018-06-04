# OfflineIMAP inside Docker

> OfflineIMAP is a GPLv2 software to dispose your mailbox(es) as a local Maildir(s).
>
> For example, this allows reading the mails while offline without the need for your mail reader (MUA) to support disconnected operations.
Source: [offlineimap.org](http://www.offlineimap.org/)

This is my personal container to run OfflineIMAP wherever I want.

## Usage

This approach is based on Docker Secrets. For this to work you have to enable Docker swarm mode on your host. This can be done with

```sh
docker swarm init
```


Checkout [Swarm Mode - Create a swarm](https://docs.docker.com/engine/swarm/swarm-mode/#create-a-swarm) for more informations.

### Handling secrets

My prefered way of handling credentials is to use Docker secrets. For OfflineIMAP my secret is the complete `.offlineimaprc` file. So first create your OfflineIMAP config file and then put it into a Docker Secret with

```sh
docker secret create offlineimaprc /path/to/your/.offlineimaprc
```


If you don't know how to setup an OfflineIMAP configuration file, please [read the docs](http://www.offlineimap.org/doc/conf_examples.html).

### Storing the mails

In all cases I don't like to mount my host filesystem into my containers. You shouldn't either, yust because. Use Docker Volumes instead. So let's create one for OfflineIMAP to store the mailboxes in:

```sh
docker volume create offlineimap_mailboxes
```


### Finally fire it up

All should be setup now. Finally run the OfflineIMAP container / Swarm service with (but double check the volume path with your configured `localfolders` config in your OfflineIMAP configuration file.

```sh
docker service create --name offlineimap \
        --mount type=volume,source=offlineimap_mailboxes,destination=/home/userless/.mail \
        --secret source=offlineimaprc,target=/home/userless/.offlineimaprc \
        bennyli/offlineimap
```


#### Log output

To see what's going on run

```sh
docker service logs -f offlineimap
```


## Advanced informations

Everybody should use SSL encrypted IMAP servers. For this to work it could be necessary that the SSL certificates of your server have been added to the hosts certificate store. My entrypoint script does handle this for you. It parses your OfflineIMAP config file, requests the SSL certificate from your server and passes it to the CA certificate store of the container OfflineIMAP is running in.

For more details take a look a my [GitHub repo](https://github.com/BennyLi/docker-apps/blob/master/apps/offlineimap/entrypoint.sh).

### Extend the restart delay

If you use this container in swarm mode (like I described above), the container will automatically restart after one sync with a delay of 5 seconds. This is a sensible default from Docker itself [see the docs](https://docs.docker.com/engine/reference/commandline/service_create/#options). As always, you can change these settings by altering the `docker service create` command. Here is an example to run OfflineIMAP again and again with a delay of 10 minutes.

```sh
docker service create --name offlineimap \
        --mount type=volume,source=offlineimap_mailboxes,destination=/home/userless/.mail \
        --secret source=offlineimaprc,target=/home/userless/.offlineimaprc \
        --restart-condition any \
        --restart-delay 10m \
        bennyli/offlineimap
```

## Contribute

The files for this image are hosted [GitHub](https://github.com/BennyLi/docker-apps/blob/master/apps/offlineimap/).
If you find a bug or like to give a hint for enhancements issue a ticket on [GitHub](https://github.com/BennyLi/docker-apps/issues).

Nothing fits your needs? You just want to give me some love and support what I'm doing? [PayPal Me](https://paypal.me/BennyLi)
