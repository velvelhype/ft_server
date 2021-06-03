FROM debian:buster

RUN apt-get update && apt-get install -y --no-install-recommends \
	nginx wget mariadb-server sysvinit-utils openssl\
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

RUN chmod +x  launcher.sh
CMD bash launcher.sh

RUN wget --no-check-certificate https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-english.tar.gz

RUN tar -xf phpMyAdmin-5.1.0-english.tar.gz && rm -rf phpMyAdmin-5.1.0-english.tar.gz

RUN mv phpMyAdmin-5.1.0-english phpmyadmin

COPY ./srcs/config.inc.php phpmyadmin

RUN wget --no-check-certificate https://wordpress.org/latest.tar.gz

RUN tar -xvzf latest.tar.gz && rm -rf latest.tar.gz 

COPY ./srcs/wp-config.php /var/www/localhost/wordpress

RUN chown -R www-data:www-data *