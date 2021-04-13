FROM alpine:latest

RUN apk update \
	&& apk --no-cache add nginx openssl

RUN mkdir -p /run/nginx && rm /etc/nginx/nginx.conf

COPY srcs/nginx.conf /etc/nginx/nginx.conf
COPY srcs/index.html /usr/share/nginx/html/index.html
COPY srcs/style.css /usr/share/nginx/html/style.css
COPY srcs/livenessprobe.sh livenessprobe.sh

# self signed ssl certificate
RUN openssl req -newkey rsa:2048 \
    -x509 \
    -days 365 \
    -nodes \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -subj '/C=FR/ST=77/L=Villeparisis/O=42/CN=celeloup'

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]