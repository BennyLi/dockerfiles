FROM bennyli/app-base
LABEL maintainer="Benny Li <dev@benny-li.de>"

USER root

RUN apt-get update && apt-get install --yes \
      wget \
      gnupg

# Add Googles public key
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
# Add Google Repo
RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list

# Install Ruby and Googles Chrome Browser
RUN apt-get update && apt-get install --yes \
      ruby2.5 ruby2.5-dev \
      build-essential \
      zlib1g-dev \
      google-chrome-stable \
      ffmpeg \
      pulseaudio socat alsa-utils

COPY ./entrypoint.sh /home/$APP_USER/entrypoint.sh
RUN chmod +x /home/$APP_USER/entrypoint.sh


USER $APP_USER

RUN echo "gem: --user-install --env-shebang --no-rdoc --no-ri" > /home/$APP_USER/.gemrc
RUN gem install watir webdrivers

COPY ./amazon-prime.rb /home/$APP_USER/amazon-prime.rb

RUN mkdir /home/$APP_USER/recordings

ENTRYPOINT ["/home/dev/entrypoint.sh"]
