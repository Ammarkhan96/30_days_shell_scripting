#!/bin/bash

echo "Removing stopped containers..."
docker container prune -f 

echo "Removing daggling images..."
docker image prune -f

echo "Removing unused networks..."
docker network prune -f

echo "Cleanup Completed"


