FROM bennyli/app-base
LABEL mainteriainer="Benny Li <dev@benny-li.de>"

USER root

RUN apt-get update && apt-get install --yes \
      neomutt \
      libsasl2-modules \
      locales \
      mime-support \
      aspell \
      ca-certificates \
      gnupg \
      openssl \
      urlview

USER $APP_USER
RUN mkdir ~/.mail

ENTRYPOINT ["neomutt"]
