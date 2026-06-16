#!/bin/bash

THRESHOLD=80
LOG_FILE="/tmp/disk_monitor.log"

USAGE=$(df / | awk 'NR==2 {gsub("%",""); print $5}')

if [ "$USAGE" -ge "$THRESHOLD" ]; then
   echo "$(date) - WARNING: Disk usage is ${USAGE}%" >> "$LOG_FILE"
   echo "Disk usage exceeded ${THRESHOLD}%"    
else 
   echo "Disk usage is normal: ${USAGE}%"
fi
