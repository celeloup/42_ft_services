FROM alpine:latest

RUN apk update \
	&& apk add --no-cache openrc nginx php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session

RUN mkdir -p /run/nginx && rm /etc/nginx/nginx.conf

COPY srcs/start.sh start.sh
COPY srcs/nginx.conf /etc/nginx/nginx.conf

RUN wget https://wordpress.org/latest.tar.gz \
	&& tar -xvf latest.tar.gz > /dev/null \
	&& rm -rf latest.tar.gz \
	&& chmod 755 -R /wordpress

COPY srcs/wp-config.php /wordpress/wp-config.php

EXPOSE 5050

CMD ["sh", "start.sh"]