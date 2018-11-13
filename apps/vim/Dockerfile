FROM debian:buster                                      
LABEL maintainer="Benny Li <dev@benny-li.de>"

#####  Runtime variables
ENV USER_ID=1000
ENV GROUP_ID=1000
ARG WORKDIR=/project-src
ENV WORKDIR=$WORKDIR

#####  Add locale
ARG LOCALE_ARG=de_DE
RUN apt-get update && apt-get install -y locales && \
    localedef -i $LOCALE_ARG -c -f UTF-8 -A /usr/share/locale/locale.alias $LOCALE_ARG.UTF-8
ENV LANG $LOCALE_ARG.utf8

#####  Get and install vim
RUN apt-get install -y git-core make gcc libncurses-dev && \
    git clone https://github.com/vim/vim.git /vim-src && \
    cd /vim-src/src && make && make install && \
    cd / && rm -rf /vim-src


#####  Cleanup
RUN rm -rf /var/lib/apt/lists/*


#####  Mountpoint for files to edit
RUN mkdir -p $WORKDIR
WORKDIR $WORKDIR
VOLUME $WORKDIR


#####  Entrypoint to setup user corresponding to host user
#####  and start vim seamlessly
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
