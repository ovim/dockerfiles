#!/bin/bash

# 获取当前项目根目录
nowPath=$(cd $(dirname $0); pwd)

# 检测是否进行初始化
if [ ! -f $nowPath"/nginx/.env" ];then
    echo "please run init.sh, exit"
    exit
fi

read -p "是否启动Nginx  [y/n] : " nginxIsStart
if [ $nginxIsStart == "y" ]; then
    cd $nowPath"/nginx/"
    docker-compose up -d
    echo "nginx status: run"
fi

read -p "是否启动PHP7.2  [y/n] : " php72IsStart
if [ $php72IsStart == "y" ]; then
    cd $nowPath"/php/7.2/"
    docker-compose up -d
    echo "php7.2 status: run"
fi

read -p "是否启动PHP7.4  [y/n] : " php74IsStart
if [ $php74IsStart == "y" ]; then
    cd $nowPath"/php/7.4/"
    docker-compose up -d
    echo "php7.4 status: run"
fi

read -p "是否启动PHP8.0  [y/n] : " php80IsStart
if [ $php80IsStart == "y" ]; then
    cd $nowPath"/php/8.0/"
    docker-compose up -d
    echo "php8.0 status: run"
fi

echo "========== Enjoy your time =========="
