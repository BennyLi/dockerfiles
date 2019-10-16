# Master PDF Editor (4.3.89) - inside docker 🚢

> Master PDF Editor is the optimal solution for editing PDF files in Linux. 
> It enables you to create, edit, view, encrypt, sign and print interactive PDF documents.
Source: [https://code-industry.net/free-pdf-editor/#get](https://code-industry.net/free-pdf-editor/#get)

This is my personal container to run the old Master PDF Editor 4.3.89 - Free Edition (without watermark) wherever I want and without the need to install additional dependencies on my system.

## TODO ☑

* Add printer support 🖨


## Usage

**See also: [Startscript @ GitHub](https://github.com/BennyLi/docker-apps/blob/master/apps/masterpdfeditor/masterpdfeditor.sh)**

### Create a config volume

First we need a place to store the configuration / settings of Master PDF Editor as the container would forget about this, everytime we start it.

```
docker volume create masterpdfeditor_config
```

### Create the container

Next we will setup the container. This will not yet start it as we need to tell the X11 session to allow the container to display stuff on our screen.

```
docker create --tty \
              --name masterpdfeditor \
              `# Open up the Display for the GUI` \
              -e "DISPLAY=unix$DISPLAY" \
              -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
              `# Mount the config and the documents folder` \
              -v masterpdfeditor_config:/home/dockuser/.config/:rw \
              -v $HOME/Documents:/home/dockuser/Documents:rw \
              bennyli/masterpdfeditor
```

Ensure that `$HOME/Documents` is where your documents are! Otherwise change the path to fit your setup.

### Configure the X11 session

Now we grab out the container id of our newly created container and get the hostname out of the setup.
This is needed to configure the X11 session so our container is allowed to display the Master PDF Editor window on the screen.

```
container_id=$(docker container ls -a -f name=masterpdfeditor -q)
container_hostname=$(docker inspect --format='{{ .Config.Hostname }}' $container_id)
```

With this hostname we can configure the X11 session to allow local connections of this container.

```
xhost +local:$container_hostname
```

### Start the container

Finally we can start MasterPDFEditor.

```
docker container start masterpdfeditor
```

## Contribute

The files for this image are hosted [GitHub](https://github.com/BennyLi/docker-apps/blob/master/apps/masterpdfeditor/).
If you find a bug or like to give a hint for enhancements issue a ticket on [GitHub](https://github.com/BennyLi/docker-apps/issues).

Nothing fits your needs? You just want to give me some love and support what I'm doing? [PayPal Me](https://paypal.me/BennyLi)
