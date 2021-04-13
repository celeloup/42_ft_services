FROM alpine:latest

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
	&& apk update \
	&& apk add --no-cache grafana

COPY srcs/influxdb.yaml /usr/share/grafana/conf/provisioning/datasources/influxdb.yaml
COPY srcs/dashboards.yaml /usr/share/grafana/conf/provisioning/dashboards/dashboards.yaml
COPY srcs/dashboards /usr/share/grafana/dashboards

WORKDIR /usr/share/grafana/conf

EXPOSE 3000

CMD	["grafana-server"]