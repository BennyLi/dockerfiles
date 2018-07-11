FROM bennyli/app-base
LABEL maintainer="Benny Li <dev@benny-li.de>"

# Install RVM
USER root
RUN apt-get update && apt-get install --yes \
      gpg \
      curl \
      procps \
      less \
      libncurses5-dev \
      build-essential \
      autoconf \
      git

RUN git clone https://github.com/eddieantonio/imgcat && \
      cd imgcat && \
      autoconf && \
      ./configure && \
      make && \
      make install

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB && \
      \curl -O https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer && \
      \curl -O https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer.asc && \
      gpg --verify rvm-installer.asc && \
      bash rvm-installer stable

# Install ruby
RUN /bin/bash -c "source /etc/profile.d/rvm.sh && \
      rvm get head && \
      rvm reload && \
      rvm install 2.1 && \
      rvm use 2.1 --default && \
      gem install mdless pygmentize"


COPY entrypoint.sh /entrypoint.sh
RUN chmod ugo+x /entrypoint.sh

USER $APP_USER
# Workdire setup
RUN mkdir /home/$APP_USER/mdless
WORKDIR /home/$APP_USER/mdless

ENTRYPOINT ["/entrypoint.sh"]
