#!/bin/bash

if [ -f app/app.txt ]
then
	echo "Application Healthy"
	exit 0
else
	echo "Application Failed"
	exit 1
fi
