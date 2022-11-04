#!/bin/bash

nowPath=$(cd $(dirname $0); pwd)

# 检测当前目录是否有 init.lock
if [ -f $nowPath"/init.lock" ];then
    echo "already init, exit"
    exit
fi

# 创建网段
# docker network create --subnet=172.172.0.0/24 dev_enviroment
# echo "网段初始化完成 [172.172.0.0/24]"

# env init
cd $nowPath"/elasticsearch/"
cp .env.example .env

cd $nowPath"/mysql/"
cp .env.example .env

cd $nowPath"/nacos/"
cp .env.example .env

cd $nowPath"/nginx/"
cp .env.example .env

cd $nowPath"/php/7.2/"
cp .env.example .env

cd $nowPath"/php/7.4/"
cp .env.example .env

cd $nowPath"/php/8.0/"
cp .env.example .env

cd $nowPath"/redis/"
cp .env.example .env

echo ".env 初始化完成"


# 初始化结束，生成 init.lock
touch $nowPath"/init.lock"
echo "===== init over, run start.sh; ====="
