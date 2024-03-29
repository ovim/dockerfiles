# ElasticSearch 集群

- cluster_master 主节点
- cluster_slave_01 子节点01
- cluster_slave_02 子节点02

https://hub.docker.com/_/elasticsearch

# 配置

## 配置权限
(每个节点都需要配置此项)
chmod -R 777 log/ data/

(设置数据备份目录写入权限)
chmod -R 777 backup

## 调整内存限制

每个节点的 `docker-compose.yml` 里的配置项 `ES_JAVA_OPTS`，所有节点的内存配置项 `ES_JAVA_OPTS` 累加不能超过服务器内存的80%

## 调整服务器的 `max_map_count`

```
cat /proc/sys/vm/max_map_count
sudo sysctl -w vm.max_map_count=262144
cat /proc/sys/vm/max_map_count
```

## 配置密码

打开 `elasticsearch.yml` 配置项 `xpack.security.enabled: true`

进入对应 `ES` 容器执行以下命令

```
cd /usr/share/elasticsearch
bin/elasticsearch-keystore create
bin/elasticsearch-setup-passwords interactive
```