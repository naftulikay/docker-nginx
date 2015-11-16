FROM phusion/baseimage:0.9.17
MAINTAINER "Naftuli Tzvi Kay <rfkrocktk@gmail.com>"

ADD scripts/service/nginx-service.sh /etc/service/nginx/run
RUN chmod 0755 /etc/service/nginx/run

ADD scripts/service/nginx-config-watcher.sh /etc/service/nginx-config-watcher/run
RUN chmod 0755 /etc/service/nginx-config-watcher/run

ADD scripts/startup/nginx-default-config.sh /etc/my_init.d/01_nginx_default_config.sh
RUN chmod 0755 /etc/my_init.d/01_nginx_default_config.sh

ADD scripts/debian/docker.list /etc/apt/sources.list.d/docker.list

ENV NGINX_VERSION=1.9.6-1~trusty

# add nginx repository
RUN apt-key adv --keyserver hkp://pgp.mit.edu --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 >/dev/null \
    && apt-get update >/dev/null \
    && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y >/dev/null \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y nginx=$NGINX_VERSION inotify-tools >/dev/null

# create a backup of the default config
RUN mkdir -m 0755 /var/lib/nginx && chown -R nginx:nginx /var/lib/nginx \
    && cd /etc && tar czf /var/lib/nginx/nginx-default-config.tar.gz nginx/
