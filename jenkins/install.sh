#!/bin/bash

# JENKINS_USER_EXIST=$(cat /etc/passwd|grep jenkins)
# if [[ -z "$JENKINS_USER_EXIST" ]];then
  # useradd -M -G docker jenkins&&echo 'user jenkins created'
# else
  # usermod -a -G docker jenkins&&echo 'append group docker to user jenkins'
# fi
# cat /etc/group |grep docker

if [[ -f "jenkins.tar" ]];then
  docker load -i jenkins.tar
else
  docker pull jenkins/jenkins:2.254
fi

LOCATION=$(pwd)

CONTAINER_EXIST=$(sudo docker ps -a|grep jenkins)
if [[ -n "$CONTAINER_EXIST" ]];then
  sudo docker stop jenkins>>/dev/null
  sudo docker rm jenkins>>/dev/null
  sudo docker rmi myjenkins>>/dev/null
fi

sudo docker build -t myjenkins .||exit 1
sudo docker rmi $(docker images|grep none|awk -F ' ' '{print $3}')>>/dev/null

mkdir -p data&&chmod 777 data
sudo docker run -d \
-u root \
--name jenkins \
--restart always \
-v $LOCATION/data:/var/jenkins_home \
-v /usr/bin/docker:/usr/bin/docker \
-v /var/run/docker.sock:/var/run/docker.sock \
-p 8080:8080 -p 50000:50000 \
myjenkins
