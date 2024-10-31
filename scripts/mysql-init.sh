#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y git curl

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh

docker run -d \
  --name mysql \
  --restart always \
  -p 3306:3306 \
  -e MYSQL_ROOT_PASSWORD=password \
  -e MYSQL_DATABASE=flaskdb \
  -e MYSQL_USER=user \
  -e MYSQL_PASSWORD=password \
  mysql:latest \
  --bind-address=0.0.0.0
