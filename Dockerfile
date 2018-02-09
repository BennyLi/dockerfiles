FROM ubuntu:17.10
LABEL maintainer="Benny Li <dev@benny-li.de>"

# Build Arguments
ARG ATOM_VERSION=1.23.3


# Install dependencies
RUN apt-get update && \
    apt-get install --yes \
      wget \
      libxss1 libasound2 libxkbfile1


# Install Atom Text Editor
RUN wget --output-document=/tmp/atom.deb https://github.com/atom/atom/releases/download/v${ATOM_VERSION}/atom-amd64.deb && \
    apt install --yes /tmp/atom.deb

# Cleanup Image
RUN apt-get autoremove && \
    apt-get clean && \
    apt-get autoclean

