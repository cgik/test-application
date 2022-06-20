#!/bin/bash

set -e
testdir=$(dirname "$0")

if [[ -z "${DIR}" ]]; then
    DIR=$(pwd)
fi

echo "starting services"
docker-compose -f $DIR/docker-compose.yaml up -d 

echo -n "waiting up to 60 sec for system to start"
while [ $(docker-compose ps | grep -c "(healthy)") != 1 ];
do
    if [[ $count -eq 6 ]]; then
       echo "! timeout reached"
       exit 1
    else
       echo -n "."
       sleep 10
       let 'count+=1'
    fi
done

echo -e "\nsetting up db"
$DIR/scripts/init-db.sh