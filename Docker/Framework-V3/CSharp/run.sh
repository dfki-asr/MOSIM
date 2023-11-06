#!/bin/bash

MIPA=$2
DOCKER_STDP=$3
DOCKER_STDIPP=${MIPA}:${DOCKER_STDP}
CSharpComponent=$4
CSharpComponent_IPP=${MIPA}:${CSharpComponent}
LAUNCHER_IPP=$5

echo "CSharp" $1 $2 $3 $4 $5

echo MIPA ${MIPA}
echo DOCKER_STDP ${DOCKER_STDP}
echo DOCKER_STDIPP ${DOCKER_STDIPP}
echo CSharpComponent ${CSharpComponent}
echo CSharpComponent_IPP ${CSharpComponent_IPP}
echo LAUNCHER_IPP ${LAUNCHER_IPP}

case $1 in

"CSharpAdapter" )

	echo "C# Adapter" ;
	
	cp /root/MOSIM/Docker/Framework/CSharpAdapter/run.sh /
	
	cd /Environment/Adapters/CSharpAdapter

	mono MMIAdapterCSharp.exe -a ${CsharpAdapter_IPP} -aint ${DOCKER_STDIPP} -r ${LAUNCHER_IPP} -m ../../MMUs

	echo "Finished" ;;

"CoordinateSystemMapper" )

	echo "Coordinate System Mapper Service" ;
	
	mono /root/MOSIM-CSharp/Services/CoordinateSystemMapper/CoordinateSystemMapper/bin/Release/CoordinateSystemMapper.exe -a ${CSharpComponent_IPP} -aint ${DOCKER_STDIPP} -r ${LAUNCHER_IPP}
	
	echo "Finished Coordinate System Mapper Service" ;;

"PostureBlending" )

    echo "Posture Blending Service" ;
    
	mono /root/MOSIM-CSharp/Services/PostureBlendingService/PostureBlendingService/bin/Release/PostureBlendingService.exe -a ${CSharpComponentIPP} -aint ${DOCKER_STDP_IPP} -r ${LAUNCHER_IPP}
	
	echo "Finished Posture Blending Service" ;;
	
* )
	echo "Unknown C# Component" ;;

esac
 
