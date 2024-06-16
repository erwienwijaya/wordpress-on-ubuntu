FROM ubuntu:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV MYSQL_ROOT_PASSWORD=rootpassword
ENV MYSQL_WORDPRESS_DB=wordpress
ENV MYSQL_WORDPRESS_USER=wordpressuser
ENV MYSQL_WORDPRESS_PASSWORD=password

# install dependencies
RUN apt-get update && apt-get install -y \
    nginx \
    php-fpm \
    php-opcache \
    php-json \
    php-mbstring \
    php-xml \
    php-zip \
    php-gd \
    php-tokenizer \
    php-mysql \
    mysql-server \
    curl \
    wget

# download wordpress from sites and extracted
RUN wget https://wordpress.org/latest.tar.gz

# extracted / unpacking latest.tar.gz
RUN tar xf latest.tar.gz

# move wordpress folder to /var/www/html
RUN mv wordpress /var/www/html

# Configuration Nginx
RUN rm /etc/nginx/sites-enabled/default
COPY default /etc/nginx/sites-available/default
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

# install and configuration PHP-FPM
RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php/*/fpm/php.ini

# set permissions
RUN chown -R www-data:www-data /var/www/html

# copy database from local to image
# COPY local-database.sql /<folder>/local-database.sql

COPY info.php /var/www/html

# Custom mysql-setting script
COPY mysql-setting.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/mysql-setting.sh

# expose port
EXPOSE 80

# execute services
ENTRYPOINT ["mysql-setting.sh"]
CMD ["nginx", "-g", "daemon off;"]