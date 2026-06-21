#!/bin/bash

CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')

echo "CPU Usage: $CPU%"
