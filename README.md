<!--
 * @Author: your name
 * @Date: 2020-07-07 19:26:37
 * @LastEditTime: 2020-07-20 12:11:42
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /workspace/README.md
--> 
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
--- gather | 快速启动包
--- --- docker-compose.yml | 一键启动 NMP（具体的启动项可编辑文件自由配置）
--- sercices | 服务软件配置包
--- --- elasticsearch | ElasticSearch 7.3.2
--- --- nginx | Nginx 服务
--- ---  --- nginx.conf | nginx 主配置文件
--- ---  --- conf.d | nginx副配置文件（站点nginx配置文件可存放在此目录下）
--- --- php | PHP 服务目录 （包含常用PHP版本的 Dockerfile）
--- --- redis | Redis 服务
--- wwwroot | app 应用目录
--- --- default | 默认测试文件

## 文档

[Docker安装](docs/guide-zh-CN/docker-install.md) · [常用命令](docs/guide-zh-CN/start-command.md) 

[comment]: <> ([Docker安装]&#40;docs/guide-zh-CN/docker-install.md&#41; · [使用文档]&#40;docs/guide-zh-CN/usage.md&#41; · [常用命令]&#40;docs/guide-zh-CN/start-command.md&#41; )

## 问题反馈

在使用中有任何问题，欢迎反馈给我，可以用以下联系方式跟我交流

QQ：[2556811689](https://jq.qq.com/?_wv=1027&k=4BeVA2r)

## 学习文档

[Docker 配置详解](https://www.jianshu.com/p/2217cfed29d7)

[Docker 入门教程](http://www.ruanyifeng.com/blog/2018/02/docker-tutorial.html)

[Docker 微服务教程](http://www.ruanyifeng.com/blog/2018/02/docker-wordpress-tutorial.html)

参考

[jianyan's dockerfile](https://github.com/jianyan74/dockerfiles)

[markhilton's docker-php-fpm](https://github.com/markhilton/docker-php-fpm)
