<?php
$redis = new Redis();
$redis->connect('172.19.0.21',6379);// 172.19.0.21 为redis的IP地址
$redis->set('test','hello docker_redis');
echo $redis->get('test');