#!/usr/bin/env bash

###########################################################
#
#            WARNING ! DANGEROUS AHEAD !     
#                                                       
# If using an editor inside a container, the user      
# inside the container is root and you mount a file    
# that is normally only editable by root from the host 
# you can just edit it without any password prompts    
# you get if you use sudo on the host.                 
# 
# Example:
#   docker run -it --rm 
#              -v /etc/hosts:/mountpoint/etc/hosts:rw 
#              --user=root 
#              bennyli/neovim /mountpoint/etc/hosts
#
############################################################





SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
PROJECT_BASE_PATH="$( cd $SCRIPTPATH/../.. ; pwd -P )"

dockerfile="Dockerfile_tpl"
container_name="neovim"

# Mount working dir or file
mount_opts=""
nvim_args=""
run_as_root_opts="--user=root"
user_opts="--user=$(id --user)"
for path in "$@"; do
  case "$path" in
    "-h"|"--help")
      cat << EOF
$(basename $0) [-h|--help] [--as-root] <file-or-path...>

       --as-root   Run neovim with root privileges
  -b,  --build     (Re)build the docker image
  -h,  --help      Print this usage message
EOF
      exit 0 
      ;;

    "-b"|"--build")
      $PROJECT_BASE_PATH/parse-includes.sh "$(pwd)/$dockerfile"
      if [ $? != 0 ]; then
        exit 1
      fi

      docker build --tag bennyli/neovim .
      if [ $? != 0 ]; then
        exit 1
      fi
      ;;

    "--as-root")
      sudo -v
      if [ $? != 0 ]; then
        exit $?
      fi
      user_opts="$run_as_root_opts"
      ;;

    *)
      absolute_opt_path="$( readlink -f $path )"
      
      # handle directories
      if [ -d "$absolute_opt_path" ]; then
        mount_opts="${mount_opts} -v $absolute_opt_path:$absolute_opt_path:rw"
        nvim_args="${nvim_args} $absolute_opt_path"
      fi

      # handle files
      if [ -f "$absolute_opt_path" ]; then
        # mount the folder of the file to get around permission issues
        mount_opts="${mount_opts} -v $(dirname $absolute_opt_path):$(dirname $absolute_opt_path):rw"
        nvim_args="${nvim_args} $absolute_opt_path"
      fi
      ;;
  esac
done

# By default the current folder will be mounted
if [ -z "$mount_opts" ]; then
  mount_opts="-v $(pwd):$(pwd):rw"
  nvim_args="$(pwd)"
fi

echo "Starting neovim inside of docker with command:"


docker run -it --rm $user_opts $mount_opts --name=$container_name bennyli/neovim $nvim_args
