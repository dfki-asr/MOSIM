This folder contains all files which are needed to create the Docker images for the core of the MOSIM Framework.
You can find the commands to create the images in the script file ..\Scripts\CreateImages.bat. This script assumes that it is run in the folder where you found this ReadMe.md file (as long as the original location show at Git Hub was not changed).
The create images script is provided for a Windows environment only because a Unity install is neccessary to create the Unity based images.
In case you do not need the Unity images or you donwlaod them from Docker Hub or any other registry you can use the Windows script as a hint to see how the other images could be created in a Unix/Linux environment.

The following Docker images can be created:

Framework components (see https://github.com/dfki-asr/MOSIM/wiki/Framework-Components):
=======================================================================================

CoSimulation

CsharpAdapter

Launcher (Console Launche version only!)

UnityAdapter

MOSIM Services (see https://github.com/dfki-asr/MOSIM/wiki/Services):
=====================================================================

BlenderIK

Coordinatesystemmapper

GraspPoseService

PostureBlendingService

RetargetingService

SkeletonAccessService

UnityPathPlanning
