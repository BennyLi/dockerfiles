FROM alpine
LABEL maintainer="Benny Li <dev@benny-li.de>"

RUN apk -U --no-progress upgrade && \
    apk -U --no-progress add taskd taskd-pki gnutls

ARG TASKDDATA
ENV TASKDDATA ${TASKDDATA:-/var/taskd}

COPY init.sh /init.sh
RUN chmod +x /init.sh

VOLUME ["${TASKDDATA}"]
EXPOSE 53589

ENTRYPOINT /usr/bin/taskd server --data ${TASKDDATA}
