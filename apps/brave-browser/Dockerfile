FROM ubuntu:18.10

#####  Runtime variables
ENV USER_ID=1000
ENV GROUP_ID=1000
ARG WORKDIR=/project-src
ENV WORKDIR=$WORKDIR

RUN apt-get update && \
    apt-get install --yes curl gnupg

RUN curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add - && \
    . /etc/os-release && \
    echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ $UBUNTU_CODENAME main" | tee /etc/apt/sources.list.d/brave-broswer-release-${UBUNTU_CODENAME}.list && \
    apt-get update && \
    apt-get install --yes brave-browser brave-keyring

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
