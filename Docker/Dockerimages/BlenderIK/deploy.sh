#!/bin/bash

BV=2.83
BD=Blender${BV}
PYCMD=python3.7m
BLENDER=blender-${BV}.10-linux64
MYPATH=/root/MOSIM-Python/Services/BlenderIK/

if [ ! -d build ] ; then mkdir build ; fi

if [ ! -d build/Blender ] ; then
	curl https://ftp.halifax.rwth-aachen.de/blender/release/${BD}/${BLENDER}.tar.xz -o ${BLENDER}.tar.xz ;
	7z x ${BLENDER}.tar.xz ;
	tar xf ${BLENDER}.tar ;
	mv ${BLENDER} build/Blender ;
	rm ${BLENDER}.tar ;
	rm ${BLENDER}.tar.xz ;
	build/Blender/${BV}/python/bin/${PYCMD} -m ensurepip ;
	build/Blender/${BV}/python/bin/${PYCMD} -m pip install --upgrade pip ;
fi

cd /tmp
git clone https://github.com/dfki-asr/MMIPython-Core.git

# build/Blender/${BV}/python/bin/${PYCMD} -m pip install https://github.com/dfki-asr/MMIPython-Core.git

${MYPATH}/build/Blender/${BV}/python/bin/${PYCMD} -m pip install /tmp/MMIPython-Core

cd ${MYPATH}
cp build-resources/version.txt build/
cp build-resources/description.json build/
# cp README.md build/
cp build-resources/service.config build/
cp build-resources/Start_IKService.sh build/

if [ ! -d build/src ] ; then
	cp -r src build/
fi

if [ ! -d build/resources ] ; then
	cp -r build-resources/resources build/
fi
