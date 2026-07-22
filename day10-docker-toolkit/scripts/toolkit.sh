#!/bin/bash

echo "===== Docker Toolkit ====="

echo "1. Generate Report"
echo "2. Cleanup Docker"
echo "3. Exit"

read -p "Choose Option:" OPTION

case $OPTION in

1)
	./scripts/monitor.sh
	;;

2)
	./scripts/cleanup.sh
	;;

3)
	exit 0
	;;

*)
	echo "Invalid Option"
	;;
esac
