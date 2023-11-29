#!/bin/bash

if [ ! -f .env ] ;
then
	echo "[31m.env file not found. This file needs to reside in the folder from which this script is called.[0m"
	echo "[31m.env needs to define all varialbes used in the Docker compose files for starting the Docker containers for the MOSIM framework.[0m"
	exit 1
fi

if [ ! -d DockerComposeFiles ] ;
then
	echo "[31mFolder DockerComposeFiles not found. This folder, which needs to contain all Docker compose files (listed below!) for the MOSIM Framework, needes to reside in the folder from which the scriped is called.[0m"
	exit 2
fi

konsole -e "docker-compose  --project-directory . --env-file ./.env -f DockerComposeFiles/Launcher.yml up" &

sleep 5

konsole -e "docker-compose  --project-directory . --env-file ./.env -f DockerComposeFiles/CSharpAdapter.yml up" &

sleep 5

konsole -e "docker-compose  --project-directory . --env-file ./.env -f DockerComposeFiles/CSharpServices.yml up" &

sleep 5

konsole -e "docker-compose  --project-directory . --env-file ./.env -f DockerComposeFiles/Unity.yml up" &

# sleep 5

# Only needed when CoSimulation should be stared separately. Most likly when Unity is not used as a target engine.
# Not extensively tested!
#
# konsole -e "docker-compose  --project-directory . --env-file ./.env -f DockerComposeFiles/Launcher.yml up" &

