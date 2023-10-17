#!/bin/bash

MIPA=$1
DOCKER_STDP=$2
DOCKER_STDIPP=${MIPA}:${DOCKER_STDP}
SkeletonAccessService=$3
SkeletonAccessService_IPP=${MIPA}:${SkeletonAccessService}
LAUNCHER_IPP=$4

# sleep 10

echo "SkeletonAccessService"

echo Hallo $1 $2 $3 $4 $5

echo MIPA ${MIPA}
echo DOCKER_STDP ${DOCKER_STDP}
echo SkeletonAccessService ${SkeletonAccessService}
echo LAUNCHER ${LAUNCHER_IPP}

echo mono SkeletonAccessService.exe -a ${SkeletonAccessService_IPP} -aint ${DOCKER_STDIPP} -r ${LAUNCHER_IPP}

mono /root/MOSIM-CSharp/Services/SkeletonAccessService/SkeletonAccessService/bin/Release/SkeletonAccessService.exe -a ${SkeletonAccessService_IPP} -aint ${DOCKER_STDIPP} -r ${LAUNCHER_IPP}
