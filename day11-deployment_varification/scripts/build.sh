#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" &&pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

source "$PROJECT_DIR/config/config.env"

echo "================BUILD================="

docker build -t ${IMAGE_NAME}:${IMAGE_TAG} "$PROJECT_DIR"

if [ $? -eq 0 ]
then
	echo "Image Build Successful"
else
	echo "Image Build Failed"
	exit 1
fi
