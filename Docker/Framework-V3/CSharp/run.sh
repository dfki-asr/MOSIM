#!/bin/bash

MIPA=$2
DOCKER_STDP=$3
DOCKER_STDIPP=${MIPA}:${DOCKER_STDP}
CSharpComponent=$4
CSharpComponent_IPP=${MIPA}:${CSharpComponent}
LAUNCHER_IPP=$5
DEBUG=$6

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
	
	/root/MOSIM/Docker/Framework-V3/CSharp/CreateEnvironment.sh "/Environment"
	
	mv /root/MOSIM-CSharp/Core/Adapter/MMIAdapterCSharp/bin/Debug/* /Environment/Adapters/CSharpAdapter
	
	if [ -z ${DEBUG} ] ;
	then
		/root/MOSIM/Docker/Framework-V3/CSharp/CopyMMUs.sh "/Environment" > ${LOG}/CSharpAdapter.log ;
	else
		/root/MOSIM/Docker/Framework-V3/CSharp/CopyMMUs.sh "/Environment" ;
	fi
	
	cd /Environment/Adapters/CSharpAdapter

	if [ -z ${DEBUG} ] ;
	then
		mono MMIAdapterCSharp.exe -a ${CSharpComponent_IPP} -aint ${DOCKER_STDIPP} -r ${LAUNCHER_IPP} -m ../../MMUs >> ${LOG}/CSharpAdapter.log ;
	else
		mono MMIAdapterCSharp.exe -a ${CSharpComponent_IPP} -aint ${DOCKER_STDIPP} -r ${LAUNCHER_IPP} -m ../../MMUs ;
	fi

	echo "Finished" ;;

"CoordinateSystemMapper" )

	echo "Starting  Coordinate System Mapper Service" ;
	
	if [ -z ${DEBUG} ] ;
	then
		mono /root/MOSIM-CSharp/Services/CoordinateSystemMapper/CoordinateSystemMapper/bin/Release/CoordinateSystemMapper.exe -a ${CSharpComponent_IPP} -aint ${DOCKER_STDIPP} -r ${LAUNCHER_IPP} > ${LOG}/CoordinateSystemMapper.log ;
	else
		mono /root/MOSIM-CSharp/Services/CoordinateSystemMapper/CoordinateSystemMapper/bin/Release/CoordinateSystemMapper.exe -a ${CSharpComponent_IPP} -aint ${DOCKER_STDIPP} -r ${LAUNCHER_IPP} ;
	fi
	
	echo "Finished Coordinate System Mapper Service" ;;

"CoSimulation" )

	echo "Starting  CoSimulation" ;

	if [ -z $8 ] ;
	then
		mono /root/MOSIM-CSharp/Core/CoSimulator/CoSimulationStandalone/bin/Release/CoSimulationStandalone.exe -a ${CSharpComponent_IPP} -aint ${DOCKER_STDIPP1} -aserv ${MIPA}:$6 -aservint ${MIPA}:$7 -r ${LAUNCHER_IPP} > ${LOG}/CoSimulation.log ;
	else
		mono /root/MOSIM-CSharp/Core/CoSimulator/CoSimulationStandalone/bin/Release/CoSimulationStandalone.exe -a ${CSharpComponent_IPP} -aint ${DOCKER_STDIPP1} -aserv ${MIPA}:$6 -aservint ${MIPA}:$7 -r ${LAUNCHER_IPP}
	fi

	echo "Finished CoSimulation" ;;
	
"Launcher" )

	echo "Starting Launcher" ;
	
	cd /root/MOSIM-CSharp/Core/Launcher/MMILauncher.Console/bin/Debug
	
	/root/MOSIM/Docker/Framework-V3/CSharp/CreateEnvironment.sh ".."
	
	/root/MOSIM/Docker/Framework-V3/CSharp/CopyMMUs.sh ".."
	
	mono MMILauncher.Console.exe -p $3 ;
	
	echo "Finshed Launcher" ;;

"PostureBlending" )

    echo "Statring  Posture Blending Service" ;
    
	if [ -z ${DEBUG} ] ;
	then
		mono /root/MOSIM-CSharp/Services/PostureBlendingService/PostureBlendingService/bin/Release/PostureBlendingService.exe -a ${CSharpComponent_IPP} -aint ${DOCKER_STDIPP} -r ${LAUNCHER_IPP} > ${LOG}/PostureBlending.log ;
	else
		mono /root/MOSIM-CSharp/Services/PostureBlendingService/PostureBlendingService/bin/Release/PostureBlendingService.exe -a ${CSharpComponent_IPP} -aint ${DOCKER_STDIPP} -r ${LAUNCHER_IPP} ;
	fi

	echo "Finished Posture Blending Service" ;;
	
"Retargeting" )

    echo "Statring Retargeting Service" ;
    
	if [ -z ${DEBUG} ] ;
	then
		mono /root/MOSIM-CSharp/Services/RetargetingService/RetargetingService/bin/Release/RetargetingService.exe -a ${CSharpComponent_IPP} -aint ${DOCKER_STDIPP} -r ${LAUNCHER_IPP} > ${LOG}/Retargeting.log ;
	else
		mono /root/MOSIM-CSharp/Services/RetargetingService/RetargetingService/bin/Release/RetargetingService.exe -a ${CSharpComponent_IPP} -aint ${DOCKER_STDIPP} -r ${LAUNCHER_IPP} ;
	fi
	
	echo "Finished Retargeting" ;;

"SkeletonAccess" )

    echo "Statring SkeletonAccess Service" ;
	
	if [ -z ${DEBUG} ] ;
	then   
		mono /root/MOSIM-CSharp/Services/SkeletonAccessService/SkeletonAccessService/bin/Release/SkeletonAccessService.exe -a ${CSharpComponent_IPP} -aint ${DOCKER_STDIPP} -r ${LAUNCHER_IPP} > ${LOG}/SkeletonAccess.log ;
	else
		mono /root/MOSIM-CSharp/Services/SkeletonAccessService/SkeletonAccessService/bin/Release/SkeletonAccessService.exe -a ${CSharpComponent_IPP} -aint ${DOCKER_STDIPP} -r ${LAUNCHER_IPP} ;
	fi
	
	echo "Finished SkeletonAccess" ;;
	
* )
	echo "Unknown C# Component" ;;

esac
 
