## Dockerfiles

搭建基础公用环境包，方便使用，支持业务不断的提升而需要一些软件的支持但由于本身不懂或耗时导致不方便安装升级的一种解决方案

> 目前还没有完整的测试过请不要在生产环境中使用

## 简介
用docker容器服务的方式搭建环境，易于维护、升级。使用前需了解Docker的基本概念，常用基本命令。 可以一条条命令执行docker命令来构建镜像，容器。这里推荐使用docker-compose来管理，执行项目，下面是使用流程。

#### 目录

目录 | 说明
---|---
--- data | 数据库文件存储
--- --- mysql | mysql数据库文件
--- docs | 使用文档
--- gather | 常用集合
--- --- nmp | Nginx、MySQL、PHP
--- ---  --- v1 | 
--- ---  --- v2 | 
--- sercices | 服务软件配置包
--- --- nginx | latest
--- ---  --- conf.d | nginx配置文件
--- --- php | 7.0-fpm/7.2-fpm可用的Dockerfile
--- wwwroot | php 应用目录
--- --- default | 默认文件

## 文档

[Docker安装](docs/guide-zh-CN/docker-install.md) · [使用文档](docs/guide-zh-CN/usage.md) · [常用命令](docs/guide-zh-CN/start-command.md) 

## 问题反馈

在使用中有任何问题，欢迎反馈给我，可以用以下联系方式跟我交流

QQ：[2556811689](https://jq.qq.com/?_wv=1027&k=4BeVA2r)

## 学习文档

[Docker 配置详解](https://www.jianshu.com/p/2217cfed29d7)

[Docker 入门教程](http://www.ruanyifeng.com/blog/2018/02/docker-tutorial.html)

[Docker 微服务教程](http://www.ruanyifeng.com/blog/2018/02/docker-wordpress-tutorial.html)
