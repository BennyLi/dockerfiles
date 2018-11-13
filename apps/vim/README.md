# Vim inside docker

> Vim is a highly configurable text editor for efficiently creating and changing any kind of text.
> -- from vim.org

This is my personal vim installation inside Docker so I can run it wherever I want.

# Usage

To run vim you could execute the following docker command.

```
docker run -it --rm \
           -v $(pwd):/project-src \
           -v ~/.vimrc:/usr/local/share/vim/vimrc \
	   bennyli/vim
```

In detail this will mount your current working directory into the container and open that in vim. It will also mount your host vim config file (assuming you have one file containing all your configs) as the system wide config for vim.

The container also assumes that your host user has the id 1000 so that the permissions fit. If this is not the case you have to alter the `docker run` command.

## Advanced usage

This is just an example. As the time of writing the following snippet is also available as a script in my Github repository.

```
MOUNTPOINTS=""
for param in $@; do
  fullpath="$(realpath $param)"
  MOUNTPOINTS="$MOUNTPOINTS -v $fullpath:$fullpath"
done

docker run -it --rm \
           -e USER_ID=$(id -u) -e GROUP_ID=$(id -g) \
           -v $(pwd):/project-src \
           -v ~/.vimrc:/usr/local/share/vim/vimrc \
           $MOUNTPOINTS \
	   bennyli/vim $@
```
