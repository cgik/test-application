#!/bin/bash

DB="testdb"
DBUSER="testuser"
PASSWORD="mypassword"
HOST="127.0.0.1"

if [[ -z "${DIR}" ]]; then
    DIR=$(pwd)
fi


echo -e "creating $DB database and $DBUSER user account"

mysql -h $HOST -u root -p$PASSWORD <<MYSQL_SCRIPT
DROP DATABASE IF EXISTS $DB;
CREATE DATABASE $DB;
CREATE USER IF NOT EXISTS '$DBUSER'@'127.0.0.1' IDENTIFIED BY '$PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO '$DBUSER'@'127.0.0.1';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

echo -e "loading table data.."

mysql -h $HOST -u $DBUSER -p$PASSWORD $DB < $DIR/scripts/db-schema.sql