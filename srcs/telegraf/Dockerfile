FROM	alpine:latest

RUN	echo "http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
	&& apk update \
	&& apk add --no-cache telegraf

COPY telegraf.conf /etc/telegraf.conf

EXPOSE	8125

CMD	["telegraf", "--config", "/etc/telegraf.conf"]