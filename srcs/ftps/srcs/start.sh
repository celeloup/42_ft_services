#! /bin/bash

adduser -D admin
echo "admin:admin" | chpasswd

echo "admin" > /etc/vsftpduserlist.conf

mkdir /var/run/vsftpd
mkdir /var/run/vsftpd/empty

/usr/sbin/vsftpd /etc/vsftpd.conf

tail -F /dev/null