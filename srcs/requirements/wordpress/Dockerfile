FROM debian:buster

RUN apt-get update
RUN apt-get -y install php7.3 php7.3-fpm php7.3-gd php7.3-xml php7.3-mbstring php7.3-mysql

COPY ./tools/wordpress-5.8.tar.gz /tmp/wordpress.tar.gz
COPY ./conf/wp-config.php /var/www/html/wp-config.php
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/

RUN tar -xf /tmp/wordpress.tar.gz -C /tmp ;\
    rm -fr /tmp/wordpress.tar.gz ;\
    mkdir -p /var/www/html ; \
    cp -r /tmp/wordpress/* /var/www/html/ ;\
    rm -fr /tmp/wordpress ;\
    chmod -R +w /var/www/html ;\
    chown -R www-data:www-data /var/www

ARG MYSQL_USER
ARG MYSQL_PASSWORD
# для подключения вп к базе:
RUN sed -i "s/_MYSQL_USER/${MYSQL_USER}/g" /var/www/html/wp-config.php ;\
    sed -i "s/_MYSQL_PASSWORD/${MYSQL_PASSWORD}/g" /var/www/html/wp-config.php ;\
    service php7.3-fpm start

EXPOSE 9000

ENTRYPOINT ["/usr/sbin/php-fpm7.3", "-F"]