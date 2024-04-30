#!/bin/bash
apt update -y
# install Docker
apt-get install docker.io -y
systemctl start docker
systemctl enable docker
# install java
apt install fontconfig openjdk-17-jre -y
# install jenkins
wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
apt-get update -y
apt-get install jenkins -y

# Add the current user to the docker group
usermod -aG docker danielle
# Add the jenkins user to the docker group
sudo usermod -aG docker jenkins
# Reboot the system
sudo reboot