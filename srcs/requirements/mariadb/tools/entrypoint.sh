#!/bin/bash

cat .db_config_done 2> /dev/null

if [ $? -ne 0 ]; then
	# mysqld_safe is the recommended way to start a mysqld server on Unix. 
	# mysqld_safe adds some safety features such as restarting the server
	# when an error occurs and logging runtime information to an error log.
	usr/bin/mysqld_safe --datadir=/var/lib/mysql &
	# Wait 
	while ! mysqladmin ping -h $MARIADB_HOST --silent; do
    	sleep 1
	done

	eval "echo \"$(cat /tmp/db-config.sql)\"" | mariadb
	touch .db_config_done
fi

usr/bin/mysqld_safe --datadir=/var/lib/mysql