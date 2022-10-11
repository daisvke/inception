FROM	alpine:3.15

RUN		apk update \
		&& apk add --no-cache --update mariadb mariadb-client bash \
		&& mkdir -p /var/lib/mysqld /run/mysqld

# Create database
COPY	./conf/db-config.sql /tmp/db-config.sql

COPY	./tools/entrypoint.sh ./
RUN 	chmod +x ./entrypoint.sh

COPY 	./conf/mariadb-server.cnf /etc/my.cnf.d/

# Mount database
RUN		mariadb-install-db --datadir=/var/lib/mysql \
		--auth-root-authentication-method=normal \
		&& chown -R mysql:mysql /var/lib/mysql \
		&& chown -R mysql:mysql /run/mysqld

ENTRYPOINT [ "sh", "entrypoint.sh" ]