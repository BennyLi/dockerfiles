FROM bennyli/app-base
LABEL maintainer="Benny Li <dev@benny-li.de>"

#####  Shell setup  #####
USER root
RUN apk add --update zsh git
RUN usermod --shell zsh $APP_USER
ENV SHELL /bin/zsh

ADD https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh omz-install.sh
RUN chmod o+rwx omz-install.sh

USER $APP_USER
RUN ./omz-install.sh 
RUN rm -f omz-install.sh

ENTRYPOINT ["/bin/zsh"]
