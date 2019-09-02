FROM debian:buster-slim
LABEL maintainer "Benny Li <dev@benny-li.de>"

ARG VERSION="2.0.0"
ARG BUILD="11050"

ARG USER_ID="1000"
ARG GROUP_ID="1000"

RUN apt-get update && apt-get install --yes curl libglib2.0-0 libgtk2.0-0 libx11-xcb1 libqt5gui5 net-tools udev procps && \
    curl -Lo /tmp/drive.deb https://global.download.synology.com/download/Tools/SynologyDriveClient/${VERSION}-${BUILD}/Ubuntu/Installer/x86_64/synology-drive-client-${BUILD}.x86_64.deb && \
    dpkg -i /tmp/drive.deb && \
    rm /tmp/drive.deb

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY drive.sh /drive.sh
RUN chmod +x /drive.sh

RUN groupadd --gid $GROUP_ID dockgroup && \
    useradd --gid $GROUP_ID --uid $USER_ID --create-home dockuser

RUN mkdir -p /home/dockuser/.config/.SynologyDrive && \
    mkdir -p /home/dockuser/Documents

ENTRYPOINT [ "/entrypoint.sh" ]
