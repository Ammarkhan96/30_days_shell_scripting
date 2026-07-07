#!/bin/bash

mkdir -p logs

LOG_FILE="logs/deply.sh"

echo "===============" >> $LOG_FILE
echo "$(date)" >> $LOG_FILE
echo "Deployment Started" >> $LOG_FILE

echo "Current Version:"

cat app/app.txt

./health_check.sh

if [ $? -eq 0 ]
then
	echo "Deployment Successful"
	echo "Deployment Successfl" >> $LOG_FILE
else
	echo "Deployment Failed"
	echo "Deployment Failed" >> $LOG_FILE
fi
