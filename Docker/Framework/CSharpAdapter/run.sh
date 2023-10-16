#!/bin/sh

MIPA=$1
DOCKER_STDP=$2
DOCKER_STDIPP=${MIPA}:${DOCKER_STDP}
CsharpAdapter=$3
CsharpAdapter_IPP=${MIPA}:${CsharpAdapter}
LAUNCHER_IPP=$4

# sleep 10

echo "C# Adapter" $1 $2 $3 $4

echo MIPA ${MIPA}
echo DOCKER_STDP ${DOCKER_STDP}
echo CsharpAdapter ${CsharpAdapter}
echo LAUNCHER ${LAUNCHER_IPP}

pwd

echo mono MMIAdapterCSharp.exe -a ${CsharpAdapter_IPP} -aint ${DOCKER_STDIPP} -r ${LAUNCHER_IPP} -m ../../MMUs

mono MMIAdapterCSharp.exe -a ${CsharpAdapter_IPP} -aint ${DOCKER_STDIPP} -r ${LAUNCHER_IPP} -m ../../MMUs
