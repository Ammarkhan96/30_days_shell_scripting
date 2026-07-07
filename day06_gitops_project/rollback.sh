#!/bin/bash

cd app || exit

git reset --hard HEAD~1

echo ""
echo "Rollback Completed"
echo ""

echo "Current Version:"


cat app.txt

