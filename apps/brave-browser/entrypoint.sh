#! /usr/bin/env sh

#####  User setup
USERNAME=brave
groupadd --gid $GROUP_ID $USERNAME
useradd --create-home --uid $USER_ID --gid $GROUP_ID $USERNAME


#####  Start $USERNAME as user
CMD="/usr/bin/$USERNAME-browser"
if [ "$#" -eq 0 ]; then
  su --command "$CMD ." - $USERNAME
else
  CMD_EXT="${CMD} ${@}"
  su --command "${CMD_EXT}" - $USERNAME
fi

