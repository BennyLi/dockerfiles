#
# docker run -it --rm 
#            -v /tmp/.X11-unix:/tmp/.X11-unix 
#            -e DISPLAY=unix$DISPLAY 
#            -v $(pwd):/root/.wine/drive_c/users/root/Application\ Data/AVM:rw
#            --name fritz-fernzugang 
#            bennyli/fritz-fernzugang
#

FROM tianon/wine

ADD https://avm.de/fileadmin/user_upload/DE/Service/VPN/FRITZ_Box-Fernzugang_einrichten.exe /usr/src/FRITZ_BOX-Fernzugang.exe

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
#CMD ["/usr/src/FRITZ_BOX-Fernzugang.exe"]
#CMD ["'c:\Program Files\FRITZ!Fernzugang einrichten\VPNAdmin.exe'"]
#CMD ["bash"]
