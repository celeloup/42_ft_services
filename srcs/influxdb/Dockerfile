FROM	alpine:latest

RUN	apk update \
    && apk add --no-cache influxdb

COPY srcs/livenessprobe.sh livenessprobe.sh

EXPOSE	8086

CMD	["influxd", "run"]