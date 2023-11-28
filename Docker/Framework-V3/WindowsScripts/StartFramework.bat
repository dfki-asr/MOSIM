@echo off

if not exist .env (
	echo [31m.env file not found. This file needs to reside in the folder from which this script is called.[0m
	echo [31m.env needs to define all varialbes used in the Docker compose files for starting the Docker containers for the MOSIM framework.[0m
	exit /b 1
)

if not exist DockerComposeFiles (
	echo "[31mFolder DockerComposeFiles not found. This folder, which needs to contain all Docker compose files (listed below!) for the MOSIM Framework, needes to reside in the folder from which the scriped is called.[0m"
	exit /b 2
)

start cmd.exe /c "docker-compose  --project-directory . --env-file .\.env -f DockerComposeFiles\Launcher.yml up

timeout /t 5

start cmd.exe /c "docker-compose  --project-directory . --env-file .\.env -f DockerComposeFiles\CSharpAdapter.yml up

timeout /t 5

start cmd.exe /c "docker-compose  --project-directory . --env-file .\.env -f DockerComposeFiles\CSharp-Services.yml up

timeout /t 5

start cmd.exe /c "docker-compose  --project-directory . --env-file .\.env -f DockerComposeFiles\Unity.yml up

timeout /t 5

REM Only needed when CoSimulation should be stared separately. Most likly when Unity is not used as a target engine.
REM Not extensively tested!
REM
REM start cmd.exe /c "docker-compose  --project-directory . --env-file .\.env -f DockerComposeFiles\Launcher.yml up
REM 
REM timeout /t 5
