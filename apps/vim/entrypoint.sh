#! /usr/bin/env sh
                                                            #####  User setup
groupadd --gid $GROUP_ID vimu
useradd --create-home --uid $USER_ID --gid $GROUP_ID vimu   chown -R vimu:vimu $WORKDIR
                                                                                                                        #####  Start vim as user                                    VIM_CMD="/usr/local/bin/vim"                                if [ "$#" -eq 0 ]; then
  su --command "cd $WORKDIR && $VIM_CMD ." - vimu
else                                                          VIM_CMD_EXT="${VIM_CMD} ${@}"                               su --command "cd $WORKDIR && ${VIM_CMD_EXT}" - vimu       fi
