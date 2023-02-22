#!/bin/bash

mkdir /Environment
mkdir /Environment/Adapters
mkdir /Environment/Adapters/CSharpAdapter
mkdir /Environment/MMUs

mv /root/MOSIM-CSharp/Core/Adapter/MMIAdapterCSharp/bin/Release/* /Environment/Adapters/CSharpAdapter

# cd /root

# cp -r ./MMUs /Environment/

cd /root/MOSIM-CSharp/MMUs

for i in * ; do 
	if [[ -d $i ]] ;
	then
		if [[ $i != "" && $i != "build" && $i != "DebugAdapter" && $i != "DebugAdapterProject" && $i != "MMUDescriptionAutoGenerator" ]] ;
		then
			echo $i ;
			if [[ -d /root/MOSIM-CSharp/MMUs/$i/bin/Debug ]]
			then
				mv /root/MOSIM-CSharp/MMUs/$i/bin/Debug /Environment/MMUs/$i
			fi
			if [[ -d /root/MOSIM-CSharp/MMUs/$i/bin/Release ]] ;
			then
				mv /root/MOSIM-CSharp/MMUs/$i/bin/Release/* /Environment/MMUs/$i
			fi
		fi
	fi
done


# rm -rf /root/MOSIM-CSharp
