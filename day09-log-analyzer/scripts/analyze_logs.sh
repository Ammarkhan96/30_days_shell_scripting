#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

source "$PROJECT_DIR/config/config.env"

DATE=$(date +"%Y-%m-%d_%H-%M-%S")

REPORT_FILE="$REPORT_DIR/report_$DATE.txt"

mkdir -p "$REPORT_DIR"
mkdir -p "$ALERT_DIR"

TOTAL=$(wc -l < "$LOG_FILE")

INFO_COUNT=$(grep -c "INFO" "$LOG_FILE")

WARNING_COUNT=$(grep -c "WARNING" "$LOG_FILE")

ERROR_COUNT=$(grep -c "ERROR" "$LOG_FILE")

{
echo "=========================="
echo "Total Logs: $TOTAL"

echo "WARNING Count: $INFO_COUNT"

echo "ERROR Count: $ERROR_COUNT"

echo
echo "Top Errors:"

grep "ERROR" "$LOG_FILE" \
| sed 's/ERROR //' \
| sort \
| uniq -c \
| sort -rn

} > "$REPORT_FILE"

if [ "$ERROR_COUNT" -ge 5 ]
then

ALERT_FILE="$ALERT_DIR/alert_$DATE.txt"

echo "CRITICAL ALERT" > "$ALERT_FILE"

echo "ERROR Count: $ERROR_COUNT" >> "$ALERT_FILE"

echo "Generated: $(date)" >> "$ALERT_FILE"

fi

echo "Report Generated: $REPORT_FILE"
