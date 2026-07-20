#!/bin/bash

mkdir -p logs
mkdir -p backups

LOGFILE="logs/pipeline.log"

echo "Pipeline Started $(date)" >> "$LOGFILE"

docker tag cicd-demo:v1 cicd-demo:backup 2>/dev/null

./scripts/build.sh

if [ $? -ne 0 ]
then
	echo "Build Failed" >> "$LOGFILE"
	exit 1
fi

./scripts/deploy.sh

./scripts/health_check.sh

if [ $? -ne 0 ]
then
	echo "Deployment Failed" >> "$LOGFILE"
	./scripts/rollback.sh

	exit 1
fi

echo "Pipeline Successful" >> "$LOGFILE"
