#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y git curl

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh

# Create application directory
mkdir capstone-flask-app
cd capstone-flask-app

# Create environment file
cat <<EOT > .env
REDIS_HOST=${redis_host}
DB_HOST=${mysql_host}
DB_USER=user
DB_PASSWORD=password
DB_NAME=flaskdb
EOT

# Run application container
docker run \
  -d \
  -p 80:5000 \
  --name web \
  --env-file .env \
  alidevs/capstone-flask-app:latest 
