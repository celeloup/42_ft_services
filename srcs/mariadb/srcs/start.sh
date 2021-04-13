#!/bin/sh

# Enabling openrc
openrc &> /dev/null
touch /run/openrc/softlevel

# Setup mariadb
/etc/init.d/mariadb setup &> /dev/null
sed -i 's/skip-networking/# skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf
service mariadb restart &> /dev/null

# Creating wordpress database, 
mysql --user=root << EOF
  CREATE DATABASE wordpress;
  DROP DATABASE test;
  CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
  GRANT ALL ON wordpress.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD' WITH GRANT OPTION;
  FLUSH PRIVILEGES;
EOF

# Import wordpress database
mysql --user=root wordpress < wp-db.sql

printf "Database started !\n"

tail -F /dev/null