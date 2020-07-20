## 克隆

```bash
git clone https://github.com/yulongcode/dockerfiles.git
```

```bash
cd dockerfiles
```

## 修改配置文件

### Nginx配置

`services/nginx/conf.d/`目录为Nginx站点配置文件存放目录，参考文件`services/nginx/conf.d/default.conf`

### 更换PHP版本

修改Nginx配置文件,`services/nginx/conf.d/xxx.conf`文件第十七行`fastcgi_pass   php72:9000;`,将其换为
`fastcgi_pass   php70:9000;`,可将网站的PHP版本由7.2更换为7.0

## 启动

1、进入程序目录([V1与V2对比](../../gather/nmp/README.md))

```
cd /path/gather/nmp/(v1/v2)
```

2、 执行安装/启动

```
docker-compose up
```

3、守护模式启用

```
docker-compose up -d
```

使用 docker-compose 基本上就这么简单，docker 就跑起来了  

4、其他说明

- MySQL默认密码：`123456` 需要更换默认密码请前往docker-compose.yml文件

5、其他简单命令

- `docker-compose stop` 关闭
- `docker-compose start` 开启
- `docker-compose restart` 重启
- `docker-compose down` 关闭容器并删除服务
- `docker-compose rm` 删除服务
- `docker-compose logs php-fpm` 查看容器日志
- `docker-compose exec php-fpm bash` 进入容器

更多可以去看 [常用命令](start-command.md)

## Elasticsearch 启动

`cd /yourPath/services/elasticsearch/`

`docker-compose up -d`
