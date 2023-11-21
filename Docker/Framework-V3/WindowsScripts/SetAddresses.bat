REM @echo off

REM Set IP to the IP address on which the docker images should be started.
SET "MOSIM_IPA=192.168.178.24"

REM Please do not change anything in this block unless you know exactly what you are planning to do.
REM The specified port numbers are exposed by the Docker images on Docker Hub and CANNOT be changed from outside of the images.
REM To change the exposed port numbers the images need to be recrated useing the respective Dockerfiles provided on GitHub.
SET "DOCKER_STDP=8900"
SET "DOCKER_STD_IPP=%MOSIM_IPA%:%DOCKER_STDP%"
SET "LAUNCHER_STDP=9009"
REM End of block of fixed expsed port numbers.

REM The port numbers specified below can be changed to serve the needs of the environemnt in which the Docker images will be used.
REM PLEASE NOTE: Port numbers must be unique, i.e. numbers in the list should differ from each other and no other process in the environment is allowed to use the respective ports
REM Please make sure that there are no dangling Docker images blocking ports. The command "docker ps -a" should give you the list of all containers Docker knows about.

SET "LAUNCHER=9009"
SET "BlenderIK=8911"
SET "CoordinateSystemMapper=8912"
SET "CoSimulation=8913"
SET "CoSimulationServ=8923"
SET "CoSimulationServInt=8901"
SET "CSharpAdapter=8914"
SET "GraspPoseService=8915"
SET "PostureBlending=8916"
SET "Retargeting=8917"
SET "SkeletonAccess=8918"
SET "UnityAdapter=8950"
SET "UnityPathPlanning=8927"
