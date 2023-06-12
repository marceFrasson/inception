FROM debian:buster

WORKDIR /var/www/html/

RUN apt update -y && apt upgrade -y && apt install -y \
	mariadb-client -y \
	wget \
	apt-utils \
	nano \
	php7.3 \
	php7.3-fpm \
	php7.3-opcache \
	php7.3-cli \
	php7.3-gd \
	php7.3-curl \
	php7.3-mysql \
	php7.3-mbstring

COPY conf/ /srcs/

RUN cp /srcs/www.conf /etc/php/7.3/fpm/pool.d/

RUN mkdir /run/php && \
	mkdir -p /var/www/html && \
	wget https://wordpress.org/latest.tar.gz && \
	tar -xzvf latest.tar.gz && \
	rm latest.tar.gz && \
	mv wordpress/* .

COPY tools/ /usr/local/bin/

RUN chmod +x /usr/local/bin/start_wordpress.sh

RUN ln -s $(find /usr/sbin -name 'php-fpm*') /usr/bin/php-fpm

ENTRYPOINT ["/usr/local/bin/start_wordpress.sh"]

EXPOSE 9000

CMD ["php-fpm7.3", "-F"]
