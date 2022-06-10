#!/bin/bash

DB="test"
USER="test"
PASSWORD="mypassword"

echo -e "Creating $DB database and $USER user account"

mysql <<MYSQL_SCRIPT
DROP DATABASE IF EXITS $DB;
CREATE DATABASE $DB;
CREATE USER IF NOT EXISTS '$USER'@'127.0.0.1' IDENTIFIED BY '$PASSWORD';
GRANT ALL PRIVILEGES ON $USER.* TO '$DB'@'127.0.0.1';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

echo -e "Loading table data.."

mysql --host=127.0.0.1 --user=$USER -password=$PASSWORD $DB < ./db-schema.sql