FROM bennyli/app-base
LABEL maintainer="Benny Li <dev@benny-li.de>"

ARG BOOSTNOTE_VERSION=0.11.4

USER root
RUN apt-get update && apt-get install --yes \
      curl \
      git \
      gconf2 \
      gconf-service \
      gvfs-bin \
      libgtk2.0-0 \
      libnotify4 \
      libnss3 \
      libxtst6 \
      python \
      xdg-utils \
      libxss1 \
      libasound2

RUN curl --location --output ./boostnote.deb https://github.com/BoostIO/boost-releases/releases/download/v${BOOSTNOTE_VERSION}/boostnote_${BOOSTNOTE_VERSION}_amd64.deb && \
      dpkg -i ./boostnote.deb && \
      rm -f boostnote.deb


USER $APP_USER
ENTRYPOINT ["boostnote"]
