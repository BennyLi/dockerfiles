#####  Install NeoVim  #####

# TODO: Can this be done by a Multistage Dockerfile?


USER root

ARG BUILD_DEPS="ninja-build libtool libtool-bin autoconf automake cmake g++ pkg-config unzip texinfo"
RUN apt-get update && apt-get install --yes $BUILD_DEPS

WORKDIR /opt
RUN git clone https://github.com/neovim/neovim.git
WORKDIR /opt/neovim
RUN make && make install

#RUN apt-get remove --yes $BUILD_DEPS && apt-get clean

ENV EDITOR "nvim"
USER $APP_USER
