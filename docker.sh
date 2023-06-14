#!/bin/bash

set -e

# Perform any pre-initialization steps here

# Set the global variable
mysql -u root -p"$MYSQL_ROOT_PASSWORD" <<EOSQL
    SET GLOBAL log_bin_trust_function_creators = 0;
EOSQL

# Perform any post-initialization steps here

exec "$@"
