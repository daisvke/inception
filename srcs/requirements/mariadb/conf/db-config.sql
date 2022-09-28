/**
mysql_secure_installation script can perform several helpful security-related
operations on your installation. The script has the following capabilities:

    Set a password for the root accounts
    Remove any remotely accessible root accounts.
    Remove the anonymous user accounts.
        This improves security because it prevents the possibility of anyone
        connecting to the MySQL server as root from a remote host.
        The results is that anyone who wants to connect as root must first be able
        to log in on the server host, which provides an additional barrier against attack.
    Remove the test database (If you remove the anonymous accounts, you might also want
    to remove the test database to which they have access).
**/
DELETE FROM	mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MARIADB_ROOT_PWD');

CREATE DATABASE $MARIADB_DB;

CREATE USER '$MARIADB_USER'@'%' IDENTIFIED by '$MARIADB_PWD';
GRANT ALL PRIVILEGES ON $MARIADB_DB.* TO $MARIADB_USER@'%';

FLUSH PRIVILEGES;