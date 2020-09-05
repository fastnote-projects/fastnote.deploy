#!/bin/bash

BUILD_TYPE=$1
ROOT_URL=$(pwd)
SERVICE_BASE_URL="src/server/Services"
PROJECT_URLS=()

#####
#安装dotnet core sdk
#####
function install_dotnet {
  DOTNET_EXIST=$(which dotnet)
  if [[ -n "$DOTNET_EXIST" ]];then
    echo "dotnet exist,version $(dotnet --version)"
    return 0
  fi
  
  apt-get install libicu-dev
  mkdir -p $HOME/dotnet

  echo "downloading dotnet core sdk..."
  wget https://download.visualstudio.microsoft.com/download/pr/4f9b8a64-5e09-456c-a087-527cfc8b4cd2/15e14ec06eab947432de139f172f7a98/dotnet-sdk-3.1.401-linux-x64.tar.gz -q -O $HOME/dotnet/dotnet.tar.gz

  cd $HOME/dotnet
  
  echo "installing dotnet core sdk..."
  tar xf dotnet.tar.gz

  ln -s $HOME/dotnet/dotnet /usr/local/bin/dotnet
  # echo "export PATH=$HOME/dotnet:$PATH">> $HOME/.bashrc
  # source $HOME/.bashrc
  
  echo "dotnet install success,version $(dotnet --version)"
}

#####
#解析参数
#####
function analyze_parameters {

  if [[ -z "$BUILD_TYPE" ]];then
    echo 'build type required'
    exit 1
  fi

  case $BUILD_TYPE in
  "all")
    echo "all from shell"
    PROJECT_URLS=(BasicService FileService IdentityService LogService NoteService TranslateService)
  ;;
  "basic")
    echo "basic from shell"
    PROJECT_URLS=(BasicService)
  ;;
  "identity")
    echo "identity from shell"
    PROJECT_URLS=(IdentityService)
  ;;
  *)
    echo "unknown build type $BUILD_TYPE"
    exit 1
  ;;
  esac

}

#####
#运行单元测试
#####
function test {
  TEST_URL=$1
  PROJECT_NAME=$(echo $TEST_URL|awk -F '/' '{print $NF}')
  TEST_URL="${TEST_URL}/${PROJECT_NAME}.Tests/${PROJECT_NAME}.Tests.csproj"
  echo "testing $TEST_URL"
  dotnet test $TEST_URL
}

#####
#打包镜像
#####
function build {
  BUILD_URL=$1
  PROJECT_NAME=$(echo $BUILD_URL|awk -F '/' '{print $NF}')
  PROJECT_FILE_URL="${BUILD_URL}/${PROJECT_NAME}.WebApi/${PROJECT_NAME}.WebApi.csproj"
  echo "build URL:${PROJECT_FILE_URL}"
  dotnet build $PROJECT_FILE_URL
  docker build -t "$(echo $PROJECT_NAME | tr '[A-Z]' '[a-z]'):latest" "${BUILD_URL}/${PROJECT_NAME}.WebApi"
  docker rmi -f $(docker images|grep none|awk -F ' ' '{print $3}')>>/dev/null
}

#####
#运行容器
#####
function run {
  IMAGE="$(echo $1 | tr '[A-Z]' '[a-z]')"
  #todo:change the port
  CONTAINER_EXIST=$(docker ps -a|grep $IMAGE)
  if [[ -n "$CONTAINER_EXIST" ]];then
    docker stop $IMAGE>>/dev/null
    docker rm $IMAGE>>/dev/null
  fi
  docker run -d --name $IMAGE -p 4000:80 $IMAGE
}

install_dotnet

analyze_parameters

for PROJECT in ${PROJECT_URLS[@]}
do
  URL="${ROOT_URL}/${SERVICE_BASE_URL}/${PROJECT}"
  test $URL
  build $URL
  run $PROJECT
done



