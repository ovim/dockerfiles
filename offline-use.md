## 准备工作

> - 本地运行相关服务
> - 服务器已安装 `docker` `docker-compose`
> - 服务器执行 `init.sh`

## 关键命令

```
打包镜像
docker save 镜像名字:版本号 > 要打包的名字.tar

将打包的镜像加载到docker
docker load < 已打包的镜像名字.tar
```

## 演示

已 `nginx`服务为例

***1、查看本地镜像***

```shell
└─[$] docker images
REPOSITORY                                   TAG       IMAGE ID       CREATED       SIZE
nginx                                        1.17      9beeba249f3e   2 years ago   127MB
```

***2、本地打包镜像***

```shell
└─[$] docker save nginx:1.17 > /Users/ovim/Desktop/nginx_image.tar
```

***3、本地上传镜像***

将打包的镜像上传至服务器指定目录

```shell
└─[$] scp /Users/ovim/Desktop/nginx_image.tar remote_ip:/root/docker_images/nginx_image.tar
```

***4、服务器加载镜像***

`docker load < nginx_image.tar`

```shell
└─[$] docker images
REPOSITORY   TAG       IMAGE ID   CREATED   SIZE
└─[$] docker load < /root/docker_images/nginx_image.tar
Loaded image: nginx:1.17
└─[$] docker images
REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
nginx        1.17      9beeba249f3e   2 years ago   127MB
```

***5、服务器配置服务***

`vim ./nginx/conf/vhost/default.conf`

***6、服务器启动 `nginx`***

```shell
└─[$] cd ./nginx/
└─[$] docker-compose up -d                                        
[+] Running 1/1
 ⠿ Container nginx  Started                                                                                                        2.4s
└─[$] docker ps
CONTAINER ID   IMAGE        COMMAND                  CREATED         STATUS         PORTS                                      NAMES
7934894d910e   nginx:1.17   "nginx -g 'daemon of…"   6 seconds ago   Up 3 seconds   0.0.0.0:80->80/tcp, 0.0.0.0:443->443/tcp   nginx
```

***7、服务器访问测试***

`http://server_name`