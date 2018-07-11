ARG APP_USER="dev"
ENV APP_USER="$APP_USER"

RUN useradd --create-home $APP_USER
