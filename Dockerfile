FROM ubuntu:14.04

MAINTAINER Kazuki Miyahara

RUN sed -i 's|archive.ubuntu.com|ftp.jaist.ac.jp/pub/Linux|g' /etc/apt/sources.list && \
  sed -i 's|archive.ubuntu.com|ftp.jaist.ac.jp/pub/Linux|g' /etc/apt/sources.list.d/proposed.list
RUN apt-get update -q && \
  apt-get upgrade -yq && \
  apt-get install wget -yq --no-install-recommends && \
  apt-get autoclean -yq

RUN touch /etc/apt/sources.list.d/nginx.list
RUN echo "deb http://nginx.org/packages/ubuntu/ trusty nginx" >> /etc/apt/sources.list.d/nginx.list
RUN echo "deb-src http://nginx.org/packages/ubuntu/ trusty nginx" >> /etc/apt/sources.list.d/nginx.list
RUN wget -O- http://nginx.org/keys/nginx_signing.key | apt-key add -
RUN apt-get update -q && \
  apt-get install nginx -yq --no-install-recommends && \
  apt-get autoclean -yq && \
  rm -rf /var/lib/apt/lists/*

# SSH
RUN cat /web/id_rsa.pub >> ~/.ssh/authorized_keys

# forward request and error logs to docker log collector
# RUN ln -sf /dev/stdout /var/log/nginx/access.log
# RUN ln -sf /dev/stderr /var/log/nginx/error.log
  
EXPOSE 80
CMD ["nginx"]