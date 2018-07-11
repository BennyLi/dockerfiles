FROM ubuntu:18.04
LABEL maintainer="Benny Li <dev@benny-li.de>"

RUN apt-get update && \
    apt-get install --yes curl

#####  Download Edraw install file  #####

RUN curl --output /tmp/edraw.run.gz --location https://www.edrawsoft.com/archives/edrawmax-8-64-de.run.gz? && \
    gunzip /tmp/edraw.run.gz && \
    chmod +x /tmp/edraw.run
RUN /tmp/edraw.run


#####  Install runtime dependencies  #####

RUN apt-get install --yes libgl1-mesa-glx libglib2.0-0 libxcb-render0 libqt5gui5


#####  User Management to not run as root  #####
RUN useradd --create-home edraw
USER edraw



ENTRYPOINT ["/opt/EdrawMax-8.7/EdrawMax"]
