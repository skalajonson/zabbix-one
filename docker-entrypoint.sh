#!/bin/bash

set -e

# Perform any pre-initialization steps here

# Create the user and execute SQL commands
mysql -u root -p"$MYSQL_ROOT_PASSWORD" <<EOSQL
    CREATE DATABASE zabbix CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
    CREATE USER 'zabbix'@'localhost' IDENTIFIED BY 'password';
    GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost';
    SET GLOBAL log_bin_trust_function_creators = 1;
EOSQL

# Perform any post-initialization steps here

exec "$@"
