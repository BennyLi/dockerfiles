FROM alpine:3.14

ARG USER_ID=1000
ARG GROUP_ID=1000

# see: https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.authors "Benny Li <dev@benny-li.de>"

RUN apk add --no-cache python3 py3-pip                && \
    `# Optional depencies`                            && \
    `# For general usage`                             && \
    apk add --no-cache file py3-chardet sudo          && \
    `# For enhanced file previews`                    && \
    apk add --no-cache      \
      libcaca-apps          \
      w3m                   \
      imagemagick           \
      ffmpeg                \
      `#atool  <== unavailable?!` \
      unrar unzip p7zip  \
      poppler-utils         \
      `#calibre  <== Must be installed manually: https://github.com/lmorel3/calibre-alpine/blob/master/Dockerfile`               \
      transmission-cli      \
      mediainfo             \
      odt2txt               \
      jq                                              && \
    #apk add --no-cache fontforge \
    #  --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
    #  --allow-untrusted                               && \
    pip install Pygments                              && \
                                                         \
    `# Install ranger`                                && \
    pip install ranger-fm



################################################################################
#
# USER SETUP
#
################################################################################

RUN addgroup -g $GROUP_ID dockergroup                && \
    adduser -G dockergroup -D -u $USER_ID dockeruser



################################################################################
#
# RUNTIME SETUP
#
################################################################################

RUN mkdir --parent /home/dockeruser/hostfs           && \
    chown --recursive dockeruser:dockergroup /home/dockeruser

WORKDIR /home/dockeruser
USER dockeruser

ENTRYPOINT [ "/usr/bin/ranger" ]
