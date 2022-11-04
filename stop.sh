#!/bin/bash

# 获取当前项目根目录
nowPath=$(cd $(dirname $0); pwd)

read -p "是否停止Nginx  [y/n] : " nginxIsStart
if [ $nginxIsStart == "y" ]; then
    cd $nowPath"/nginx/"
    docker-compose stop
    echo "nginx status: stop"
fi

read -p "是否停止PHP7.2  [y/n] : " php72IsStart
if [ $php72IsStart == "y" ]; then
    cd $nowPath"/php/7.2/"
    docker-compose stop
    echo "php7.2 status: stop"
fi

read -p "是否停止PHP7.4  [y/n] : " php74IsStart
if [ $php74IsStart == "y" ]; then
    cd $nowPath"/php/7.4/"
    docker-compose stop
    echo "php7.4 status: stop"
fi

read -p "是否停止PHP8.0  [y/n] : " php80IsStart
if [ $php80IsStart == "y" ]; then
    cd $nowPath"/php/8.0/"
    docker-compose stop
    echo "php8.0 status: stop"
fi

echo "========== GoodBye =========="
