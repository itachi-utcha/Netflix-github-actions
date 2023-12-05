#!/bin/bash 

sudo apt-get update
sudo apt install docker.io -y
sudo usermod -aG docker ubuntu
newgrp docker
sudo chmod 777 /var/run/docker.sock

docker run -d -p 9000:9000 --name sonar sonarqube:lts-community


