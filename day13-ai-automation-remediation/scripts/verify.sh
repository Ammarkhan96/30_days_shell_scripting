#!/bin/bash

set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$PROJECT_DIR/config/config.env"

CURRENT_USAGE=$(df / | awk 'NR==2 {gsub("%","",$5); print $5}')

echo
echo "======================================"
echo "          VERIFICATION"
echo "======================================"

echo "Current Disk Usage : ${CURRENT_USAGE}%"
echo "Threshold          : ${DISK_THRESHOLD}%"
echo

if [ "$CURRENT_USAGE" -lt "$DISK_THRESHOLD" ]; then

    STATUS="RESOLVED"

    echo "✅ Incident resolved."

else

    STATUS="UNRESOLVED"

    echo "⚠️ Disk usage is still above threshold."

fi

REPORT="$REPORT_DIR/incident-$(date +%Y%m%d-%H%M%S).md"

cat > "$REPORT" <<EOF
# AI Auto-Remediation Incident Report

## Timestamp

$(date)

## Hostname

$(hostname)

## Disk Usage

${CURRENT_USAGE}%

## Threshold

${DISK_THRESHOLD}%

## AI Decision

$(cat "$PROJECT_DIR/logs/ai_decision.json")

## Final Status

${STATUS}

## Remediation

Docker image cleanup was attempted.

EOF

echo
echo "📄 Incident report generated:"
echo "$REPORT"
