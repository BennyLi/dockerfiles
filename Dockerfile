FROM ubuntu:17.10
LABEL maintainer="Benny Li <dev@benny-li.de>"

# Build Arguments
ARG ATOM_VERSION=1.23.3




# User Management to not run as root
RUN useradd --create-home dev




# Install dependencies
RUN apt-get update && \
    apt-get install --yes \
      wget \
      libxss1 libasound2 libxkbfile1

# Install Atom Text Editor
RUN wget --output-document=/tmp/atom.deb https://github.com/atom/atom/releases/download/v${ATOM_VERSION}/atom-amd64.deb && \
    apt install --yes /tmp/atom.deb


# Install Atom packages (... as the user)
USER dev
RUN apm install language-docker




# Cleanup Image
USER root
RUN apt-get autoremove && \
    apt-get clean && \
    apt-get autoclean




USER dev
