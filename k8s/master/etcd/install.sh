#!/bin/bash

function preRequire {
  if [[ -z "$(which docker)" ]];then echo "docker not found";exit 1;fi
  if [[ ! -f "etcd.tar.gz" ]];then echo "please go to https://github.com/etcd-io/etcd/releases to download etcd package";exit 1;fi
  
}

function buildDockerImage {
  docker build -t etcd .
}

preRequire

buildDockerImage

