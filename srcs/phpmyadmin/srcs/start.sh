#!/bin/sh

# Prevent php from clearing the environment
sed -i 's/;clear_env = no/clear_env = no/g' /etc/php7/php-fpm.d/www.conf

php-fpm7
nginx -g "daemon off;"