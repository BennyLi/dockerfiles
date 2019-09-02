#! /bin/sh

INSTALL_PATH="/opt/Synology/SynologyDrive"
LIB_PATH="$INSTALL_PATH/lib"
BIN_PATH="$INSTALL_PATH/bin/launcher"
export LD_LIBRARY_PATH=$LIB_PATH

export DISPLAY="$1"

echo "DISPLAY: $DISPLAY"

$BIN_PATH
sleep 10 # Wait a moment for the drive stuff to initiate



# Dirty active wait for the background process of the client
drive_is_running() {
	ps -ax | grep  /home/dockuser/.SynologyDrive/SynologyDrive.app/bin/ | grep -v grep > /dev/null
	return $?
}

while drive_is_running
do
	echo "Waiting for cloud drive ui to exit..."
	sleep 5
done
