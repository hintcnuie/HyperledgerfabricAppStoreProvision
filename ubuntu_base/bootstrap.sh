#!/usr/bin/env bash

  apt-get update
  apt-get -y upgrade
  apt-get -y install curl
  echo "Configure golang 1.8.3 start"
  wget https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz
  tar -xvf go1.8.3.linux-amd64.tar.gz
  mv go /usr/local
  #GO VARIABLES
  echo "export GOROOT=/usr/local/go"   >>  /etc/profile
  echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile
  #END GO VARIABLES
  go version
  go env
  echo "Configure golang 1.8.3 end"
  echo "Configure Docker CE START"
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  apt-get update
  apt-cache policy docker-ce
  apt-get install -y docker-ce
  systemctl enable docker
  docker version
  #curl -L https://github.com/docker/compose/releases/download/1.14.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
  #chmod +x /usr/local/bin/docker-compose
  apt-get install python-pip -y
  yes | pip install docker-compose
  docker-compose --version