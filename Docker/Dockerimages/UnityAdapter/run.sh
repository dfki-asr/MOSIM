#/bin/bash

echo $*
echo $1

if [ -d "./../data/" ] 
then
    cp -R ./../data/* ./MMUs 
fi


./UnityAdapter $*
