If you are not familiar with Docker, please visit www.docker.com/get-started .

The Docker images for all components of the MOSIM Framework are available at: hub.docker.com

The public repository on Docker Hub is mosim01.

You can use PullImages.sh to download the images to your local machine.

We recommend pulling the images before you try to start them using StartImages.bat because (depending on the download speed) the pause times in the start script might be too short which could make some images fail to connect to the launcher image.

Please make sure that you set the environment variable MOSIM_IPA in .SetAddresse to the IP address of the machine on which you want to run the framework.

If you are using Unity as a target engine, please make sure that you also set the IP address in Unity in Scene and Avatar in the MMI plugins to the IP address of the machine where you have the framework running.
Remote access to the framework should work out of the box. However, using localhost (127.0.0.1) when Unity and the Framework run on the same machine is not supported.

By default, we do not support a distributed setting for the MOSIM Framework (i.e. the provided scripts assume that all components of the Framework run on the same machine), however, it is straight modify what is there to get to a distributed setting.

Provided bash scripts:

PullImages.sh:
	Pulls all images of the Framework from Docker Hub.
	It is recommended to pull the images first before you try to start them.

StartImagesDockerHub.sh:
	Starts all images for the Framework.
	Please use Windows command line window and make sure that environment variable MOSIM_IPA is set to IP address of the machine.
	
.SetAddresses:
	The script sets all environment variables which are needed in the StartImagesDockerHub.sh script.
	The environment variable MUST be set to the IP address of the machine which hosts the MOSIM Framework.
	The scripts assume that all components of the MOSIM Framework are hosted by the same machine with a single IP address.
	For complex setups where the components should be started on different machines the scripts need to be rewritten.

StopContainers.sh:
	Stops all running containers.
	Please note: This stops all containers on the machine not just the MOSIM containers!

RemoveContainers.sh:
	Removes all containers.
	Please note: Containers must be stopped before they can be deleted.
	Please note: This removes all containers on the machine not just the MOSIM containers!

RemoveImages.sh:
	Removes all images.
	Please note: This removes all images on the machine not just the MOSIM images!
	
