## 简介

搭建基础公用环境包，方便使用，支持业务不断的提升而需要一些软件的支持但由于本身不懂或耗时导致不方便安装升级的一种解决方案

使用前请确保服务器已安装 `docker` `docker-compose` [安装参考](docker-install.md)

## 使用

### 目录介绍

|目录/文件 | 说明|
|---|---|
|**./init.sh** | **初始化脚本** |
|**./start.sh** | **快速启动容器脚本** |
|**./stop.sh** | **快速停止容器脚本** |
|**./nginx/** | **Nginx 服务目录** |
|./nginx/conf/nginx.conf | nginx.conf 目录 |
|./nginx/conf/vhost | Nginx 站点配置文件目录 |
|./nginx/log/ | Nginx 日志目录 |
|**./php/** | **PHP 服务目录** |
|./php/7.2/ | PHP7.2 服务目录 |
|./php/7.2/configs/ | PHP7.2 主配置文件目录 (php.ini、www.conf) |
|**./mysql/** | **MySQL服务目录** |
|./mysql/conf.d/ | MySQL 主配置文件目录 (my.cnf) |
|./mysql/data/ | MySQL 数据存储目录 |
|./mysql/log/ | MySQL 运行日志目录 |
|**./wwwroot/**| **app应用目录** |

### 快速使用

#### 预备

给快捷脚本添加可执行权限

```shell
chmod +x init.sh start.sh stop.sh
```

#### 初始化

***执行命令对使用环境进行初始化***

```shell
./init.sh
```

> 脚本工作内容:
> 
> - 创建网段
> - env初始化

#### 启动

***执行命令启动基础工作环境***

```shell
./start.sh
```

> 脚本工作内容:
>
> - 可根据自身需要启动工作环境 [Nginx、PHP7.2、PHP7.4、PHP8.0]

#### 停止

***执行命令停止基础工作环境***

```shell
./stop.sh
```

> 脚本工作内容:
>
> - 可根据自身需要停止工作环境 [Nginx、PHP7.2、PHP7.4、PHP8.0]

#### 运行站点

***运行测试站点***

`./nginx/conf/vhost/default.conf` 中默认配置了 `http://dev.loc` 站点，务必在 `/etc/hosts` 中添加此域名

浏览器访问 `http://dev.loc/index.php`

***自行搭建站点***

以 `http://new.loc` 为例

0、

配置域名解析

```shell
vim /etc/hosts
# 在文件中添加以下内容
127.0.0.1    new.loc
```

1、

`./nginx/conf/vhost/` 目录下新增 `new.loc.conf` 文件

`new.loc.conf` 参考：

```conf
server {
        listen       80;
        server_name  new.loc;

        root   /wwwroot/new/;

        location ~ \.php$ {
            fastcgi_pass   php8.0:9000;
            fastcgi_index  index.php;
            fastcgi_param  SCRIPT_FILENAME   $document_root$fastcgi_script_name;
            include        fastcgi_params;
       }
}
```

2、

写站点的测试代码

```shell
vim ./wwwroot/new/index.php
```

`index.php` 参考：

```php
<?php

phpinfo();
```

3、

执行 `./start.sh` 启动环境 (若环境以启动，执行 `docker restart nginx` 重启 `Nginx` 即可)

浏览器访问 `http://new.loc/index.php`


### 进阶使用

#### 了解 .env

每个服务目录下与 `docker-composer.yml` 同级都有一个 `.env` 文件，用来配置常用的配置项，例如 IP、PORT等。具体可查看服务下的 `.env` 文件

#### 了解服务

| 服务 | IP   | PORT | 备注 |
| ---- | ---- | ---- | ----|
| 宿主机 | 172.172.0.1 |  |  |
| Nginx | 172.172.0.2 | 80、443 |		 |
| Redis | 172.172.0.3 | 6379 | 默认密码：`cloud@redis` |
| Nacos | 172.172.0.4 | 8848 | 账号：`nacos` 密码：`nacos` |
| MySQL5.7 | 172.172.0.5 | 3306 | 账号：`root` 密码：`root`；账号：`default` 密码：`default` |
| ElasticSearch | 172.172.0.6 | 9200、9300 |  |
| PHP7.2 | 172.172.0.7 | 9000 |  |
| PHP7.4 | 172.172.0.8 | 9000 |  |
| PHP8.0 | 172.172.0.9 | 9000、9501 |  |
| Ubuntu | 172.172.0.10 |  |  |

#### 启动服务

每个独立的服务下都配备有相关的 `docker-compose.yml`，在服务目录下执行 `docker-compose up -d` 进行启动即可

#### PHP容器安装扩展

***以在 `PHP8.0` 容器安装 `redis` 为例：***

在 `http://pecl.php.net/` 中查看对应PHP版本对应的扩展版本

执行安装命令，并重启对应 `PHP` 容器

安装命令参考( `PHP8.0` 容器中执行)：

```shell
pecl install redis-5.1.0 && docker-php-ext-enable redis
```

重启命令参考：

```shell
docker restart php8.0
```

> 快速启用/停用扩展
> 
> 1、将容器内 `/usr/local/etc/php/conf.d/` 中的对应扩展配置文件 复制到宿主机的 `./php/8.0/configs/conf.d/` 目录中
> 
> 2、修改对应服务的 `docker-compose.yml` 中的挂载文件， 新增挂载
> 
> `- ./configs/conf.d/docker-php-ext-redis.ini:/usr/local/etc/php/conf.d/docker-php-ext-redis.ini:rw`



## 问题反馈

在使用中有任何问题，欢迎反馈给我，点击意见反馈跟我交流

<a target="_blank" href="http://mail.qq.com/cgi-bin/qm_share?t=qm_mailme&email=2bavsLS6tbasvZmoqPe6trQ" style="text-decoration:none;"><img src="http://rescdn.qqmail.com/zh_CN/htmledition/images/function/qm_open/ico_mailme_11.png"/></a>

## TODO

- `node` 服务
