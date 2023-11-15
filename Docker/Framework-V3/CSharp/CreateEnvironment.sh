#!/bin/bash

if [ -z "$1" ]
then
	echo "Path to location of Environment must be given."
	echo "It is assumed that folders for the envirment are created in the folder the path is pointing to, an explicit Environment folder is NOT created."
fi

if [ ! -d $1 ]
then
	mkdir $1
fi

mkdir $1/Adapters
mkdir $1/Adapters/CSharpAdapter
mkdir $1/Launcher
mkdir $1/MMUs
mkdir $1/Services

