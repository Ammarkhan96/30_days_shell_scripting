#!/bin/bash

set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$PROJECT_DIR/config/config.env"

CURRENT_USAGE=$(df / | awk 'NR==2 {gsub("%","",$5); print $5}')

echo "======================================"
echo "      AI AUTO-REMEDIATION SYSTEM"
echo "======================================"
echo
echo "Disk Usage : ${CURRENT_USAGE}%"
echo "Threshold  : ${DISK_THRESHOLD}%"
echo

if [ "$CURRENT_USAGE" -ge "$DISK_THRESHOLD" ]; then

    echo "🚨 ALERT: Disk usage threshold exceeded!"
    echo
    echo "Starting incident response..."
    echo

    "$PROJECT_DIR/scripts/collect_context.sh"

else

    echo "✅ System is healthy."
    echo "No remediation required."

fi
