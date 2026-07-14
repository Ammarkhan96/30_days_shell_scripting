#!/bin/bash

PROJECT_DIR="$HOME/Documents/30_days_shell_scripting/day07-cron-health-monitor"

(crontab -l 2>/dev/null; echo "*/5 * * * * $PROJECT_DIR/scripts/health_report.sh") | crontab

echo "Cron Job Added Successfully"

