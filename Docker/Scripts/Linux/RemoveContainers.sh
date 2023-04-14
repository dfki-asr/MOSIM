#!/bin/bash

echo "Removing all containers ..."

docker rm $( docker ps -q -a )
