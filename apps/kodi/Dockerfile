FROM bennyli/app-base
LABEL maintainer="Benny Li <dev@benny-li.de>"

USER root

RUN apt-get update && apt-get install --yes \
      kodi \
      kodi-pvr-hts

USER $APP_USER

ENTRYPOINT ["kodi"]
