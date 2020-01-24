FROM debian:buster-slim
LABEL maintainer "Benny Li <dev@benny-li.de>"

# Set the locale
RUN apt-get update && apt-get install --yes locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    sed -i -e 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG de_DE.UTF-8
ENV LANGUAGE de_DE:de
ENV LC_ALL de_DE.UTF-8

# Install dependencies
RUN apt-get update && apt-get install --yes curl \
                                            libx11-6 libxmu6 libxext6 libxrender1 libxrandr2 libgl1-mesa-glx procps mime-support

RUN curl --location --silent https://www.softmaker.net/down/softmaker-office-2018_972-01_amd64.deb --output /tmp/softmaker-office.deb && \
    dpkg -i /tmp/softmaker-office.deb
#RUN curl -Ls https://www.softmaker.net/down/softmaker-freeoffice-2018_966-01_amd64.deb -o /tmp/softmaker-office.deb && \
#    dpkg -i /tmp/softmaker-office.deb
#    touch /usr/share/freeoffice2018/portable.txt #Otherwise the config is not stored correctly ?!

RUN groupadd --gid 1000 dockgroup && \
    useradd --gid 1000 --uid 1000 dockuser

RUN mkdir -p /home/dockuser/Documents && \
    mkdir -p /home/dockuser/Media && \
    mkdir -p /home/dockuser/SoftMaker && \
    chown -R dockuser:dockgroup /home/dockuser

USER "dockuser"

