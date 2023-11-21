#!/bin/bash

if ! [ -f $1 ] ; then
	echo "Cannot find file" %1
	exit 1
fi

if ! [ -f ./.env ] ; then
	echo "dcup.bat needs to be called from a folder where .\.evn is available."
	echo "The docker images for the desired services need to already available locally or"
	echo "build folders have to be provided in the folder --project-directory . Default is the folder where .env is sitting."
	exit 1
fi

docker-compose  --project-directory . --env-file ./.env -f $1 up
