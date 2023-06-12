# base image for debian
FROM            debian:buster

# install mariadb-server
RUN             apt-get update && apt-get install -y \
                apt-utils \
                mariadb-server \
                procps \
                nano \
                && mkdir -p /var/run/mysqld \
                 && chown -R mysql:mysql /var/run/mysqld

# copy intialization script
COPY            ./tools/start_db.sh /usr/local/bin/
COPY		./conf/wordpress.sql /

EXPOSE          3306

ENTRYPOINT ["start_db.sh"]

# start the mariadb service when the container is run
# allows remote connections from any host 
CMD ["mysqld", "--bind-address=0.0.0.0"]

