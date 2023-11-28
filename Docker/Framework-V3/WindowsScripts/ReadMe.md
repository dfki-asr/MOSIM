This folder contains Windows bat scripts which support ease of use of Docker images in general but especially for the MOSIM Framework.

CreateImages.bat
	Creates the Docker images for CSharp and Unity.
	Please note:
		The docker images are created in the local repository of the machine which hosts Docker.
		If the images should be available for other environments tag.bat and push.bat needs to be used to publish the images on Docker Hub.
		Docker login is necessary to push images to Docker Hub. 
	
dcup.bat
	Shows the command which should be used to create and run the Docker Containers for the MOSIM Framework by using docker-compose.
	The Script needs to be called from a folder in which a .env file and the folder DockerComposeFiles is present.
	In DockerComposeFiles the respective yml files must reside for starting containers.
	Examples of how these yml files should look like are given in the corresponding folder on Docker Hub (MOSIM/Docker/Framework-V3/DockerComposeFiles).
	.env needs to define all variables which are used in the yml file that will be used.
	If the standard .env file given on GitHub is used, the IP address of the Docker's host system needs to be given in TWO(!) lines of this file.
pull.bat
	Pulls the Docker images of MOSIM Framework from Docker Hub.
	Useful if the images should be downloaded to a new machine without directly executing them

push.bat
	Pushes the Docker images of the MOSIM Framework to Docker Hub.
	However, Docker login for Docker Hub is needed and the Docker images need to be properly taged.

RemoveContainers.bat
	Removes ALL stopped Docker containers (i.e. not only the Docker images of the MOSIM Framework!).

RemoveImages.bat
	Removes ALL Docker images (i.e. not only the images of the MOSIM Framework!).

StartFramework.bat
	Creates and runs all containers for the MOSIM Framework.

StopContainers.bat
	Stops all running containers (i.e. not only containers of the MOSIM Framework!).

tag.bat
	Tags the Docker images of the Docker images of the MOSIM Framework to prepare pushing them to Docker Hub using push.bat.