#!/bin/bash

echo "=================="
echo "SERVER REPORT"
echo "=================="

echo
echo "Hostname"
hostname

echo
echo "uptime"
uptime

echo
echo "CPU Usage"
top -bn1 | grep Cpu

echo 
echo "Memory Usage"
free -h

echo 
echo "Disk Usage"
df -h

echo 
echo "Running Services"
systemctl list-unit --type=service --state=running | head

echo
echo "Open Ports"
ss -tuln

