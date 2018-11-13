#! /usr/bin/env sh                                      

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
