#!/bin/bash

echo "Rolling Back..."

docker rm -f cicd-demo

docker run -d --name cicd-demo -p 8080:80 cicd-demo:backup

echo "Rollback Complete"
