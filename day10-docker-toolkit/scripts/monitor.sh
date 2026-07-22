#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

source "$PROJECT_DIR/config/config.env"

DATE=$(date +"%Y-%m-%d_%H-%M-%S")

REPORT_FILE="$REPORT_DIR/docker_report_$DATE.txt"

mkdir -p "$REPORT_DIR"

{
echo "=============================="
echo "DOCKER HEALTH REPORT"
echo "=============================="
echo

echo "Running Containers"
docker ps

echo
echo "All Containers"
docker ps -a

echo
echo "Docker Images"
docker images

echo
echo "Docker Disk Usage"
docker system df

} > "$REPORT_FILE"

echo "Report Generated: $REPORT_FILE"
