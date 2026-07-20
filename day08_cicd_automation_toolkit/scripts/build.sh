#!/bin/bash

echo "Building Docker Image..."

docker build -t cicd-demo:v1 .

if [ $? -eq 0 ]
then
	echo "Build Successful"
else
	echo "Build Failed"
	exit 1
fi
