#!/bin/bash

MEM=$(free | awk '/Mem/ {printf("%.0f"), $3/$2 * 100}')

echo "Memory Usage: $MEM%"

if [ "$MEM" -gt 80 ]
then
    echo "High memory usage detected"
fi
