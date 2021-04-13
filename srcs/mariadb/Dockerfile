FROM alpine:latest

RUN apk update \
	&& apk add --no-cache mariadb mariadb-client openrc

COPY srcs/start.sh start.sh
COPY srcs/wp-db.sql wp-db.sql
COPY srcs/livenessprobe.sh livenessprobe.sh

EXPOSE 3306

CMD ["sh", "start.sh"]