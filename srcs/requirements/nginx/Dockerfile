FROM debian:buster

RUN apt-get update
RUN apt-get install -y nginx openssl

ARG DOMAIN_NAME
ARG CERTS_KEY
ARG CERTS_CRT

RUN mkdir /etc/nginx/ssl
COPY ${CERTS_CRT} /etc/nginx/ssl/nginx_cert.crt
COPY ${CERTS_KEY} /etc/nginx/ssl/.nginx_cert.key
COPY ./conf/nginx.conf /etc/nginx/sites-available/default

RUN sed -i "s/DOMAIN_NAME/${DOMAIN_NAME}/g" /etc/nginx/sites-available/default
RUN sed -i "0,/nginx/s/nginx/docker-nginx/i" /usr/share/nginx/html/index.html

ENTRYPOINT ["nginx", "-g", "daemon off;"]