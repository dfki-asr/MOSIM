#!/bin/bash

MIPA=$2
DOCKER_STDP=$3
DOCKER_STDIPP=${MIPA}:${DOCKER_STDP}
CSharpComponent=$4
CSharpComponent_IPP=${MIPA}:${CSharpComponent}
LAUNCHER_IPP=$5

LOG="/tmp/MOSIM"

echo "CSharp" $1 $2 $3 $4 $5

echo MIPA ${MIPA}
echo DOCKER_STDP ${DOCKER_STDP}
echo DOCKER_STDIPP ${DOCKER_STDIPP}
echo CSharpComponent ${CSharpComponent}
echo CSharpComponent_IPP ${CSharpComponent_IPP}
echo LAUNCHER_IPP ${LAUNCHER_IPP}

echo LOG=${LOG}

if [ ! -d ${LOG} ]
then
	mkdir ${LOG}
fi

case $1 in

"CSharpAdapter" )

	echo "Starting C# Adapter" ;
	
	/root/CreateEnvironment.sh "/Environment"
	
	mv /root/MOSIM-CSharp/Core/Adapter/MMIAdapterCSharp/bin/Release/* /Environment/Adapters/CSharpAdapter
	
	/root/CopyMMUs.sh "/Environment" > ${LOG}/CSharpAdapter.log
	
	cd /Environment/Adapters/CSharpAdapter

	mono MMIAdapterCSharp.exe -a ${CSharpComponent_IPP} -aint ${DOCKER_STDIPP} -r ${LAUNCHER_IPP} -m ../../MMUs >> ${LOG}/CSharpAdapter.log

	echo "Finished" ;;

"CoordinateSystemMapper" )

	echo "Statring  Coordinate System Mapper Service" ;
	
	mono /root/MOSIM-CSharp/Services/CoordinateSystemMapper/CoordinateSystemMapper/bin/Release/CoordinateSystemMapper.exe -a ${CSharpComponent_IPP} -aint ${DOCKER_STDIPP} -r ${LAUNCHER_IPP} > ${LOG}/CoordinateSystemMapper.log
	
	echo "Finished Coordinate System Mapper Service" ;;
	
"Launcher" )

	echo "Starting Launcher" ;
	
	cd /root/MOSIM-CSharp/Core/Launcher/MMILauncher.Console/bin/Debug
	
	/root/MOSIM/Docker/Framework-V3/CSharp/CreateEnvironment.sh ".."
	
	/root/MOSIM/Docker/Framework-V3/CSharp/CopyMMUs.sh ".."
	
	mono MMILauncher.Console.exe -p ${DOCKER_STDP} ;
	
	echo "Finshed Launcher" ;;

"PostureBlending" )

    echo "Statring  Posture Blending Service" ;
    
	mono /root/MOSIM-CSharp/Services/PostureBlendingService/PostureBlendingService/bin/Release/PostureBlendingService.exe -a ${CSharpComponent_IPP} -aint ${DOCKER_STDIPP} -r ${LAUNCHER_IPP} > ${LOG}/PostureBlending.log
	
	echo "Finished Posture Blending Service" ;;
	
"Retargeting" )

    echo "Statring Retargeting Service" ;
    
	mono /root/MOSIM-CSharp/Services/RetargetingService/RetargetingService/bin/Release/RetargetingService.exe -a ${CSharpComponent_IPP} -aint ${DOCKER_STDIPP} -r ${LAUNCHER_IPP} > ${LOG}/Retargeting.log
	
	echo "Finished Retargeting" ;;

"SkeletonAccess" )

    echo "Statring SkeletonAccess Service" ;
    
	mono /root/MOSIM-CSharp/Services/SkeletonAccessService/SkeletonAccessService/bin/Release/SkeletonAccessService.exe -a ${CSharpComponent_IPP} -aint ${DOCKER_STDIPP} -r ${LAUNCHER_IPP} > ${LOG}/SkeletonAccess.log
	
	echo "Finished SkeletonAccess" ;;
	
* )
	echo "Unknown C# Component" ;;

esac
 
