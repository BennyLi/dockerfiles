FROM debian:buster-slim
LABEL maintainer "Benny Li <dev@benny-li.de>"

ARG VERSION="4.3.89"

RUN apt-get update && apt-get install --yes curl \
                                            libsane libqt5svg5 libqt5printsupport5

RUN mkdir --parent /opt/master-pdf-editor && \
    curl -Ls http://code-industry.net/public/master-pdf-editor-${VERSION}_qt5.amd64.tar.gz -o /tmp/master-pdf-editor.tar.gz && \
    tar -xzf /tmp/master-pdf-editor.tar.gz --strip-components=1 -C /opt/master-pdf-editor/

RUN groupadd --gid 1000 dockgroup && \
    useradd --gid 1000 --uid 1000 dockuser

RUN mkdir -p /home/dockuser/Documents && \
    chown -R dockuser:dockgroup /home/dockuser

USER "dockuser"
ENTRYPOINT ["/opt/master-pdf-editor/masterpdfeditor4"]
