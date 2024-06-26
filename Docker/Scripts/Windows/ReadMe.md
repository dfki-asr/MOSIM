If you are not familiar with Docker, please visit www.docker.com/get-started .

The Docker images for all components of the MOSIM Framework are available at: hub.docker.com

You can use PullImages.bat to download the images to your local machine.

We recommend pulling the images before you try to start them using StartImages.bat because (depending on the download speed) the pause times in the start script might be too short which could make some images fail to connect to the launcher image.

If you are using Unity as a target engine, please make sure that you set the environment variable MOSIM_IPA in SetAddresses.bat to the IP address of the machine on which you want to run the framework.

Please make sure that you also set the IP address in Unity in Scene and Avatar in the MMI plugins to the IP address of the machine where you have the framework running.
Remote access to the framework should work out of the box. However, using localhost (127.0.0.1) when Unity and the Framework run on the same machine is not supported.

By default, we do not support a distributed setting for the MOSIM framework (i.e. the provided scripts assume that all components of the Framework run on the same machine), however, it is straight modify what is there to get to a distributed setting.

Provided bat scripts:

CreateImages.bat:
	Creates all Docker images for the MOSIM Framework.
	The script assumes that it is run from the Dockerimages folder where all files, which are needed to create the images, reside for the respective MOSIM components.

PullImages.bat:
	Pulls all images of the Framework from Docker Hub.
	
PushImages.bat:
	Pushes all images to Docker Hub.
	Before pushing the images need to be tagged accordingly.

StartImages.bat:
	Starts all images for the Framework.
	Please use Windows command line window and make sure that environment variable MOSIM_IPA is set to IP address of the machine.
	
SetAddresses.bat:
	The script sets all environment variables which are needed in the StartImages.bat script.
	The environment variable MUST be set to the IP address of the machine which hosts the MOSIM Framework.
	The scripts assume that all components of the MOSIM Framework are hosted by the same machine with a single IP address.
	For complex setups where the components should be started on different machines the scripts need to be rewritten.

StopContainers.bat:
	Stops all running containers.
	Please note: This stops all containers on the machine not just the MOSIM containers!

RemoveContainers.bat:
	Removes all containers.
	Please note: Containers must be stopped before they can be deleted.
	Please note: This removes all containers on the machine not just the MOSIM containers!

RemoveImages.bat:
	Removes all images.
	Please note: This removes all images on the machine not just the MOSIM images!

TagImages.bat:
	Tags all images of the Framework to prepare the upload to Docker Hub.
	
