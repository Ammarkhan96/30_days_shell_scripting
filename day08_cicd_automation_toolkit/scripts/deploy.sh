#!/bin/bash

echo "Deploying Application..."

docker rm -f cicd-demo 2>/dev/null

docker run -d --name cicd-demo -p 8080:80  cicd-demo:v1

echo "Deployment Complete"
