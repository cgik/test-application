#!/bin/bash

set -e
testdir=$(dirname "$0")

echo "starting services"
docker-compose -f ../docker-compose.yaml up -d 

echo -n "waiting up to 60 sec for system to start"
until [[ $(docker-compose ps | grep -c "(healthy)") == 1 ]];
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