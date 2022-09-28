FROM	alpine:3.14

RUN		apk update \
		&& apk add --no-cache --update php7					\
										php7-fpm			\
										php7-phar			\
										php7-json			\
										php7-curl			\
										php7-mysqli			\
										php7-iconv			\
										php7-pecl-mailparse	\
										php7-gd 			\
										mariadb-client		\
										curl				\
										bash				\
		&& mkdir -p /var/www/html \
		&& curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
			--output /usr/bin/wp \
		&& chmod +x ./usr/bin/wp \
		&& wp core download --path=/var/www/html \
		&& adduser -S nginx &&	addgroup -S nginx

WORKDIR /var/www/html

COPY	./conf/www.conf /etc/php7/php-fpm.d/www.conf
COPY	./conf/wp-config /config/wp-config
COPY	./img/ /tmp/img/
COPY	./tools/entrypoint.sh /tmp/entrypoint.sh
RUN		chmod +x /tmp/entrypoint.sh

ENTRYPOINT ["sh", "/tmp/entrypoint.sh"]