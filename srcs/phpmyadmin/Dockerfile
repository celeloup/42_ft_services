FROM alpine:latest

RUN apk update \
	&& apk add --no-cache openssl nginx php7 php7-fpm php7-opcache php7-gd php7-mysqli \
    	php7-zlib php7-curl php7-mbstring php7-json php7-session phpmyadmin

RUN mkdir -p /run/nginx && rm /etc/nginx/nginx.conf

COPY srcs/start.sh start.sh
COPY srcs/nginx.conf /etc/nginx/nginx.conf
COPY srcs/config.inc.php /etc/phpmyadmin/config.inc.php

RUN openssl req -newkey rsa:2048 \
    -x509 \
    -days 365 \
    -nodes \
    -subj '/C=FR/ST=77/L=Villeparisis/O=42/CN=celeloup' \
	-out /etc/ssl/certs/nginx-selfsigned.crt \
    -keyout /etc/ssl/private/nginx-selfsigned.key

EXPOSE 5000

CMD ["sh", "start.sh"]