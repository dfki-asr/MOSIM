#!/bin/bash

MIPA=$1
DOCKER_STDP=$2
DOCKER_STDIPP=${MIPA}:${DOCKER_STDP}
RetargetingService=$3
RetargetingService_IPP=${MIPA}:${RetargetingService}
LAUNCHER_IPP=$4

# sleep 10

echo "RetargetingService" $1 $2 $3 $4

echo MIPA ${MIPA}
echo DOCKER_STDP ${DOCKER_STDP}
echo DOCKER_STDIPP ${DOCKER_STDIPP}
echo RetargetingService ${RetargetingService}
echo RetargetingService_IPP ${RetargetingService_IPP}
echo LAUNCHER_IPP ${LAUNCHER_IPP}

echo mono RetargetingService.exe -a ${MIPA}:${RetargetingService} -aint ${MIPA}:${DOCKER_STDP} -r ${MIPA}:${LAUNCHER_IPP}

mono /root/MOSIM-CSharp/Services/RetargetingService/RetargetingService/bin/Release/RetargetingService.exe -a ${RetargetingService_IPP} -aint ${DOCKER_STDIPP} -r ${LAUNCHER_IPP}
