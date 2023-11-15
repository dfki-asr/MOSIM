#!/bin/bash

if [ -z "$1" ]
then
	echo "Path to location of Environment must be given."
	echo "It is assumed that folders for the envirment are created in the folder the path is pointing to, an explicit Environment folder is NOT added."
fi

cd /root/MOSIM-CSharp/MMUs

for i in * ; do 
	if [[ -d $i ]] ;
	then
		if [[ $i != "" && $i != "build" && $i != "DebugAdapter" && $i != "DebugAdapterProject" && $i != "MMUDescriptionAutoGenerator" ]] ;
		then
			echo $i ;
			if [[ -d /root/MOSIM-CSharp/MMUs/$i/bin/Debug ]]
			then
				mv /root/MOSIM-CSharp/MMUs/$i/bin/Debug $1/MMUs/$i
			fi
			if [[ -d /root/MOSIM-CSharp/MMUs/$i/bin/Release ]] ;
			then
				mv /root/MOSIM-CSharp/MMUs/$i/bin/Release/* $1/MMUs/$i
			fi
		fi
	fi
done
