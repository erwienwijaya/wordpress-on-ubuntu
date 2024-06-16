# Wordpress on Ubuntu

## _You Don't Need Any More Settings_

[![Build Status](https://travis-ci.org/erwien/wordpress-on-ubuntu.svg?branch=master)](https://travis-ci.org/erwien/wordpress-on-ubuntu)

What do you see in this image:

- Ubuntu
- MySQL
- Nginx
- PHP-FPM

## Features

- Customize freely and add new library
- Support for laravel and other PHP project

Ensure your're already have **Docker** engine on local.

## Build and Run

Wordpress on Ubuntu is very easy to install and deploy in a Docker container.

**Docker** build image.

```sh
docker build --no-cache -t <youruser>/wp-on-ubuntu .
```

**Docker** run image.

```sh
docker run -d -p 80:80 \
-e MYSQL_ROOT_PASSWORD=myrootpassword \
-e MYSQL_WORDPRESS_DB=mywordpressdb \
-e MYSQL_WORDPRESS_USER=mywordpressuser \
-e MYSQL_WORDPRESS_PASSWORD=mywordpresspassword \
--name wordpress-ubuntu <youruser>/wp-on-ubuntu
```

## Running on Browser

Verify the deployment by navigating to your server address in your preferred browser.

Test server

```sh
localhost:80
```

Install wordpress

```sh
localhost:80/wordpress
```

## License

MIT

**Happy scripting!**
