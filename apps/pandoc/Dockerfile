#
# Example:
#   docker run -it --rm -v $(pwd):/home/dev/pandoc bennyli/pandoc my-markdown-file.md -o my-markdown-as-pdf.pdf
#
#
FROM bennyli/app-base
LABEL maintainer="Benny Li <dev@benny-li.de>"

USER root
RUN apt-get update && apt-get install --yes \
      pandoc \
      texlive-full

USER $APP_USER

RUN mkdir /home/$APP_USER/pandoc
WORKDIR /home/$APP_USER/pandoc

ENTRYPOINT ["pandoc"]
