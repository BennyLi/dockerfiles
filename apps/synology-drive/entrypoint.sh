#! /bin/sh

chown -R dockuser:dockgroup /home/dockuser

su -l dockuser /drive.sh "$DISPLAY"
