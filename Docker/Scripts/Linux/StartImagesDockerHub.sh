#!/usr/bin/bash

source .SetAddresses

# if [[ -z "${MOSIM_IPA}"  &&  ! -v "${MOSIM_IPA}" ]]; then
if [ -z "${MOSIM_IPA}" ]; then
    echo "[31mIP address of host not set![0m"
    echo "[31mPlease set environment variable MOSIM_IPA to the IP address of the host on which you want to run the images.[0m"
    echo "[31mPlease note: Using localhost (127.0.0.1) is not supported so far![0m"
    exit 1
fi

if [[ -z "${DOCKER_STDP}" ]]; then
	echo "[31mDOCKER_STDP is not defined which should give the standard prot number used in the Docker imagages![0m"
	echo "[31mPlease set environment variable MOSIM_IPA to the IP address of the host on which you want to run the images.[0m"
	echo "[31mPlease note: Using localhost (127.0.0.1) is not supported so far![0m"
	exit 1
fi

echo "Starting Launcher ..."
docker run -d -p ${LAUNCHER}:${LAUNCHER} -it -v /home/kuf/Repositories/GitHub/MOSIM/Docker/data:/data mosim01/launcher:latest
sleep 10

echo "Starting Blender IK Service ..."
docker run -d -p ${BlenderIK}:${DOCKER_STDP} -t mosim01/blenderik:latest -a ${MOSIM_IPA}:${BlenderIK} -aint ${DOCKER_STD_IPP} -r ${MOSIM_IPA}:${LAUNCHER} -l
sleep 10

echo "Starting C# Adapter ..."
docker run -d -p ${CSharpAdapter}:${DOCKER_STDP} -t mosim01/csharpadapter:latest -a ${MOSIM_IPA}:${CSharpAdapter} -aint ${DOCKER_STD_IPP} -r ${MOSIM_IPA}:${LAUNCHER} -m ../../MMUs
sleep 5

echo "Starting Co-Simulation ..."
docker run -d -p ${CoSimulation}:${DOCKER_STDP} -p ${CoSimulationServ}:${CoSimulationServInt} -t mosim01/cosimulation:latest -a ${MOSIM_IPA}:${CoSimulation} -aint ${DOCKER_STD_IPP} -aserv ${MOSIM_IPA}:${CoSimulationServ} -aservint ${MOSIM_IPA}:${CoSimulationServInt}  -r ${MOSIM_IPA}:${LAUNCHER}
sleep 5

echo "Starting Unity Adapter ..."
docker run -d -p ${UnityAdapter}:${DOCKER_STDP} -t mosim01/unityadapter -a ${MOSIM_IPA}:${UnityAdapter} -aint ${DOCKER_STD_IPP} -r ${MOSIM_IPA}:${LAUNCHER} -m ./MMUs
sleep 5

echo "Starting Coordinate System Mapper Service ..."
docker run -d -p ${CoordinateSystemMapper}:${DOCKER_STDP} -t mosim01/coordinatesystemmapper:latest -a ${MOSIM_IPA}:${CoordinateSystemMapper} -aint ${DOCKER_STD_IPP} -r ${MOSIM_IPA}:${LAUNCHER}
sleep 5

echo "Starting Posture Blending Service ..."
docker run -d -p ${PostureBlending}:${DOCKER_STDP} -t mosim01/postureblending:latest -a ${MOSIM_IPA}:${PostureBlending} -aint ${DOCKER_STD_IPP} -r ${MOSIM_IPA}:${LAUNCHER}
sleep 5

echo "Starting Retargetting Service ..."
docker run -d -p ${Retargeting}:${DOCKER_STDP} -t mosim01/retargeting:latest -a ${MOSIM_IPA}:${Retargeting} -aint ${DOCKER_STD_IPP} -r ${MOSIM_IPA}:${LAUNCHER}
sleep 5

echo "Starting Skeleton Access Service ..."
docker run -d -p ${SkeletonAccess}:${DOCKER_STDP} -t mosim01/skeletonaccess:latest -a ${MOSIM_IPA}:${SkeletonAccess} -aint ${DOCKER_STD_IPP} -r ${MOSIM_IPA}:${LAUNCHER} -l
sleep 5

echo "Starting Unity Path Planning Service ..."
docker run -d -p ${UnityPathPlanning}:${DOCKER_STDP} -t mosim01/unitypathplanning -a ${MOSIM_IPA}:${UnityPathPlanning} -aint ${DOCKER_STD_IPP} -r ${MOSIM_IPA}:${LAUNCHER}
sleep 5

# docker run -d -p 9091:9091 -l -t mosim01/unityik -a ${MOSIM_IPA}:9091 -r ${MOSIM_IPA}:9009 -l
# sleep 5


