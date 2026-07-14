#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

source "$PROJECT_DIR/config/config.env"

mkdir -p "$REPORT_DIR"
mkdir -p "$(dirname "$LOG_FILE")"

DATE=$(date +"%Y-%m-%d_%H-%M-%S")

REPORT_FILE="$REPORT_DIR/report_$DATE.txt"

{
echo "================================="
echo "SERVER HEALTH REPORT"
echo "Generated: $(date)"
echo "================================="
echo

echo "Hostname:"
hostname

echo
echo "System Uptime:"
uptime

echo
echo "Memory Usage:"
free -h

echo
echo "Disk Usage:"
df -h /

echo
echo "Top 5 Memory Consuming Processes:"
ps aux --sort=-%mem | head -6

echo
echo "Top 5 CPU Consuming Processes:"
ps aux --sort=-%cpu | head -6

} > "$REPORT_FILE"

echo "$(date) - Report Generated: $REPORT_FILE" >> "$LOG_FILE"

echo "Report Generated Successfully"
