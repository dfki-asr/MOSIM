@echo on

if not exist "%1" (
	echo "Cannot find file" %1
	exit /b 0
)

if not exist .\.env (
	echo "dcup.bat needs to be called from a folder where .\.evn is available."
	echo "The docker images for the desired services need to already available locally or"
	echo "build folders have to be provided in the folder --project-directory . Default is the folder where .env is sitting."
	exit /b 0
)

docker-compose  --project-directory . --env-file .\.env -f %1 up
