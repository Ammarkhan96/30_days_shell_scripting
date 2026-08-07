#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

source "$PROJECT_DIR/config/config.env"

mkdir -p "$REPORT_DIR"
mkdir -p "$LOG_DIR"

DATE=$(date +"%Y-%m-%d_%H-%M-%S")

REPORT="$REPORT_DIR/ssl_report_$DATE.txt"

LOGFILE="$LOG_DIR/ssl_monitor.log"

echo "======================================" > "$REPORT"
echo "SSL CERTIFICATE EXPIRY REPORT" >> "$REPORT"
echo "Generated: $(date)" >> "$REPORT"
echo "======================================" >> "$REPORT"
echo "" >> "$REPORT"

while read DOMAIN
do

if [ -z "$DOMAIN" ]
then
continue
fi

echo "Checking $DOMAIN..."

EXPIRY=$(echo | openssl s_client -servername "$DOMAIN" -connect "$DOMAIN:443" 2>/dev/null \
| openssl x509 -noout -enddate 2>/dev/null \
| cut -d= -f2)

if [ -z "$EXPIRY" ]
then

echo "Domain : $DOMAIN" >> "$REPORT"
echo "Status : FAILED" >> "$REPORT"
echo "Reason : SSL Certificate Not Found" >> "$REPORT"
echo "-------------------------------------" >> "$REPORT"

echo "$(date) : $DOMAIN FAILED" >> "$LOGFILE"

continue

fi

EXPIRY_SECONDS=$(date -d "$EXPIRY" +%s)

TODAY_SECONDS=$(date +%s)

DAYS_LEFT=$(( (EXPIRY_SECONDS - TODAY_SECONDS)/86400 ))

STATUS="OK"

if [ "$DAYS_LEFT" -le "$WARNING_DAYS" ]
then

STATUS="WARNING"

fi

echo "Domain : $DOMAIN" >> "$REPORT"
echo "Expiry : $EXPIRY" >> "$REPORT"
echo "Remaining Days : $DAYS_LEFT" >> "$REPORT"
echo "Status : $STATUS" >> "$REPORT"
echo "-------------------------------------" >> "$REPORT"

echo "$(date) : $DOMAIN Checked Successfully" >> "$LOGFILE"

done < "$DOMAIN_FILE"

echo ""
echo "Report Generated Successfully"

echo "$REPORT"
