FROM ubuntu:17.10
LABEL maintainer="Benny Li <dev@benny-li.de>"
ARG VERSION="0.12.4"

RUN apt-get update && \
    apt-get install --yes curl xz-utils

RUN curl --output /tmp/wkhtmltopdf.tar.xz --location https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/${VERSION}/wkhtmltox-${VERSION}_linux-generic-amd64.tar.xz && \
    tar -xf /tmp/wkhtmltopdf.tar.xz -C /opt && \
    rm /tmp/wkhtmltopdf.tar.xz

RUN ln -s /opt/wkhtmltox/bin/wkhtmltopdf /usr/local/bin/wkhtmltopdf && \
    ln -s /opt/wkhtmltox/bin/wkhtmltoimage /usr/local/bin/wkhtmltoimage

RUN apt-get update && \
    apt-get install --yes zlib1g fontconfig libfreetype6 libx11-6 libxext6 libxrender1

RUN apt-get install --yes w3m w3m-img

ENTRYPOINT ["wkhtmltoimage"]
