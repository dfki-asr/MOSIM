#!/bin/bash

MIPA=$1
DOCKER_STDP=$2
DOCKER_STDP_IPP=${MIPA}:${DOCKER_STDP}
PostureBlendingService=$3
PostureBlendingService_IPP=${MIPA}:${PostureBlendingService}
LAUNCHER_IPP=$4

# sleep 10

echo "PostureBlendingService"

echo Hallo $1 $2 $3 $4

echo MIPA ${MIPA}
echo DOCKER_STDP ${DOCKER_STDP}

echo PostureBlendingService ${PostureBlendingService}
echo PostureBlendingService_IPP ${PostureBlendingService_IPP}
echo LAUNCHER_IPP ${LAUNCHER}
echo DOCKER_STDP_IPP ${DOCKER_STDP_IPP}
echo mono GraspPointService.exe -a ${PostureBlendingService_IPP} -aint ${DOCKER_STDP_IPP} -r ${LAUNCHER_IPP}

mono /root/MOSIM-CSharp/Services/PostureBlendingService/PostureBlendingService/bin/Release/PostureBlendingService.exe -a ${PostureBlendingService_IPP} -aint ${DOCKER_STDP_IPP} -r ${LAUNCHER_IPP}
