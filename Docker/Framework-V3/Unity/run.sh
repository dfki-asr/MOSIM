#!/bin/bash

MIPA=$2
DOCKER_STDP=$3
DOCKER_STDIPP=${MIPA}:${DOCKER_STDP}
UnityComponent=$4
UnityComponent_IPP=${MIPA}:${UnityComponent}
LAUNCHER_IPP=$5

echo "Unity" $1 $2 $3 $4 $5

echo MIPA ${MIPA}
echo DOCKER_STDP ${DOCKER_STDP}
echo DOCKER_STDIPP ${DOCKER_STDIPP}
echo UnityComponent ${UnityComponent}
echo UnityComponent_IPP ${UnityComponent_IPP}
echo LAUNCHER_IPP ${LAUNCHER_IPP}

case $1 in

"Adapter" )
	echo "Adapter" ;

	if [ -d "./../data/" ] ; then cp -R ./../data/* Environment/MMUs ; fi ;
	
	cd Environment/Adapters/UnityAdapter ;

	chmod +x UnityAdapter

	./UnityAdapter -a ${UnityComponent_IPP} -aint ${DOCKER_STDIPP} -r ${LAUNCHER_IPP} -m ../../MMUs ;

	echo "Finished" ;;

"PathPlanningService" )
	echo "PathPlanningService" ;
	
	cd Environment/Services/UnityPathPlanning ;

	chmod +x UnityPathPlanningService

	./UnityPathPlanningService -a ${UnityComponent_IPP} -aint ${DOCKER_STDIPP} -r ${LAUNCHER_IPP} ;;

"IKService" )
        echo "Unity IK Service" ;
    
	cd Environment/Services/UnityIKService

	chmod +x UnityIKService

	./UnityIKService -a ${UnityComponent_IPP} -aint ${DOCKER_STDIPP} -r ${LAUNCHER_IPP} ;;
	
* )
	echo "Unknown Component" ;;

esac
 
