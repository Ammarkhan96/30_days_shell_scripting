#!/bin/bash

sleep 5 

STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080)

if [ "$STATUS" == "200" ]
then
	echo "Health Check Passed"
	exit 0
else
	echo "Health Check Failed"
	exit 1
fi

