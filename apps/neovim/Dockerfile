# Generated Dockerfile! Do not edit!
# Source /home/bln/dev/private/docker-apps/apps/neovim/Dockerfile_tpl
#####  NEOVIM builder  #####

FROM debian as neovim
LABEL maintainer "Benny Li <dev@benny-li.de>"

# Build NeoVim
ARG BUILD_DEPS="ninja-build libtool libtool-bin autoconf automake cmake g++ pkg-config unzip texinfo git curl"
RUN apt-get update && apt-get install --yes $BUILD_DEPS

WORKDIR /opt
RUN git clone https://github.com/neovim/neovim.git neovim
WORKDIR /opt/neovim
RUN make clean &&     make CMAKE_BUILD_TYPE=RelWithDebInfo &&     make install





#####  Final IMAGE  #####

FROM debian
LABEL maintainer "Benny Li <dev@benny-li.de>"

ARG APP_USER="dev"
ENV APP_USER="$APP_USER"

RUN useradd --create-home $APP_USER

# Runtime dependencies
RUN apt-get update && apt-get install --yes curl git

# Copy binary
COPY --from=neovim /usr/local/share/nvim /usr/local/share/nvim
COPY --from=neovim /usr/local/bin/nvim /usr/local/bin/nvim

# Setup symlinks
RUN ln -s /usr/local/bin/nvim /usr/local/bin/vim

# Mount point for files
RUN mkdir /mountpoint &&       chown $APP_USER:$APP_USER /mountpoint


USER $APP_USER
ENV EDITOR "nvim"
ENTRYPOINT ["nvim"]

# Copy configs
COPY config/nvim/* /home/dev/.config/nvim/

# Setup neovim plugin manager
RUN curl --fail --location --output ~/.local/share/nvim/site/autoload/plug.vim --create-dirs     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN nvim +PlugInstall +qa
