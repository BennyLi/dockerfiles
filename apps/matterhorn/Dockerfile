FROM ubuntu:18.04

ARG VERSION=50200.4.0

RUN apt-get update && apt-get install --yes curl libtinfo-dev ncurses-bin bzip2 iputils-ping ca-certificates netbase tzdata


RUN echo "Download matterhorn version ${VERSION} !" && \
    curl -Lo /tmp/matterhorn.tar.bz2 https://github.com/matterhorn-chat/matterhorn/releases/download/50200.4.0/matterhorn-${VERSION}-ubuntu-18.04-bionic-x86_64.tar.bz2 && \
    mkdir /matterhorn && \
    tar -C /matterhorn --strip-components=1 -xf /tmp/matterhorn.tar.bz2

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
