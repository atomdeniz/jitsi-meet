FROM nginx:latest

USER root

RUN apt-get update && apt-get -y install --reinstall build-essential \
    && apt-get -y install curl gnupg git \
    && curl -sL https://deb.nodesource.com/setup_10.x  | bash - \
    && apt-get -y install nodejs

COPY /config /config

# create site folder
RUN mkdir -p /srv

# copy site file to container site folder
COPY /jitsi-meet /srv/jitsi-meet

RUN cd srv/jitsi-meet/ \
    && npm install \
    && make

# create SSL folder
# RUN mkdir -p /etc/nginx/ssl

# copy ssl files to container ssl folder
# COPY ./ssl /etc/nginx/ssl/

EXPOSE 80
EXPOSE 443

# VOLUME ["/config", "/etc/letsencrypt", "/srv/jitsi-meet/transcripts"]

COPY /config/nginx/nginx.conf /etc/nginx/nginx.conf
