#!/bin/bash

MIPA=$1
DOCKER_STDP=$2
DOCKER_STDIPP=${MIPA}:${DOCKER_STDP}
CoordinateSystemMapper=$3
CoordinateSystemMapper_IPP=${MIPA}:${CoordinateSystemMapper}
LAUNCHER_IPP=$4

echo "Hello World!"

echo Hallo $1 $2 $3 $4

echo MIPA ${MIPA}
echo DOCKER_STDP ${DOCKER_STDP}
echo DOCKER_STDIPP ${DOCKER_STDIPP}
echo CoordinateSystemMapper ${CoordinateSystemMapper}
echo CoordinateSystemMapper_IPP ${CoordinateSystemMapper_IPP}
echo LAUNCHER_IPP ${LAUNCHER_IPP}

mono /root/MOSIM-CSharp/Services/CoordinateSystemMapper/CoordinateSystemMapper/bin/Release/CoordinateSystemMapper.exe -a ${CoordinateSystemMapper_IPP} -aint ${DOCKER_STDIPP} -r ${LAUNCHER_IPP}
