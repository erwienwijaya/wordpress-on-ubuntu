#!/bin/bash
set -e

# Start MySQL service
service mysql start

# Inisialisasi database jika belum ada
if [ ! -d "/var/lib/mysql/${MYSQL_WORDPRESS_DB}" ]; then
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}'; FLUSH PRIVILEGES;"
    mysql -e "CREATE DATABASE ${MYSQL_WORDPRESS_DB};"
    mysql -e "CREATE USER '${MYSQL_WORDPRESS_USER}'@'localhost' IDENTIFIED BY '${MYSQL_WORDPRESS_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_WORDPRESS_DB}.* TO '${MYSQL_WORDPRESS_USER}'@'localhost';"
    mysql -e "FLUSH PRIVILEGES;"

    # Import database use below statement with remove mark (#) 
    # mysql -u root -p${MYSQL_ROOT_PASSWORD} ${MYSQL_WORDPRESS_DB} < /docker-entrypoint-initdb.d/local-database.sql
fi

# Start PHP-FPM service
service php8.3-fpm start

# Start Nginx service
nginx -g 'daemon off;'

exec "$@"
