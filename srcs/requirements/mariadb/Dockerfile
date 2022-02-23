FROM debian:buster

RUN apt-get update
RUN apt-get install -y mariadb-server
COPY ./conf/my.cnf /etc/mysql/my.cnf
COPY ./tools/wordpress.sql /tmp

ARG MYSQL_ROOT_PASSWORD
ARG MYSQL_PASSWORD
ARG MYSQL_USER
ARG DOMAIN_NAME

RUN sed -i "s/DOMAIN_NAME/${DOMAIN_NAME}/g" /tmp/wordpress.sql ;\
    chown -R mysql:mysql /var/lib/mysql && mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld

RUN service mysql start ; \
    echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password ;\
    echo "CREATE USER ${MYSQL_USER}@"'`%` identified by '"'${MYSQL_PASSWORD}';" | mysql -u root --skip-password ;\
    echo "GRANT ALL PRIVILEGES ON wordpress.* TO '$MYSQL_USER'@"'`%` WITH GRANT OPTION;' | mysql -u root --skip-password ;\
    echo "UPDATE mysql.user SET plugin='mysql_native_password' where user=""'$MYSQL_USER';" | mysql -u root --skip-password ;\
    mysqladmin -u root password ${MYSQL_ROOT_PASSWORD} ;\
    echo "FLUSH PRIVILEGES;" | mysql -uroot -p${MYSQL_ROOT_PASSWORD} ;\
    mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD} wordpress < /tmp/wordpress.sql

EXPOSE 3306
ENTRYPOINT ["mysqld"]
