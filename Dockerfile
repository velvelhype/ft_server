FROM debian:buster

RUN apt-get update && apt-get install -y --no-install-recommends \
	nginx wget mariadb-server openssl \
	php-fpm \
	php-cgi \
	php-common \
	php-pear \
	php-mysql \
	php-mbstring \
	php-zip \
	php-net-socket \
	php-xml-util \
	php-gettext \
	php-bcmath \
    php-gd

    RUN mkdir /var/www/localhost
    COPY srcs/localhost /etc/nginx/sites-available
    RUN ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled
    WORKDIR /var/www/localhost
    RUN openssl req -x509 \
        -nodes -days 30 \
        -subj "/C=JP" \
        -newkey rsa:2048 \
        -keyout /etc/ssl/ssl-k.key -out /etc/ssl/ssl-c.crt;

COPY ./srcs/launcher.sh ./
CMD bash launcher.sh
