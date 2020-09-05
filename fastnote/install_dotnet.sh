#!/bin/bash

DOTNET_EXIST=$(which dotnet)
if [[ -n "$DOTNET_EXIST" ]];then
  dotnet --version
  exit 0
fi

mkdir -p $HOME/dotnet
wget https://download.visualstudio.microsoft.com/download/pr/4f9b8a64-5e09-456c-a087-527cfc8b4cd2/15e14ec06eab947432de139f172f7a98/dotnet-sdk-3.1.401-linux-x64.tar.gz -O $HOME/dotnet/dotnet.tar.gz

cd $HOME/dotnet

tar xvf dotnet.tar.gz

echo "export PATH=$HOME/dotnet:$PATH">> $HOME/.bashrc
source $HOME/.bashrc

dotnet --version