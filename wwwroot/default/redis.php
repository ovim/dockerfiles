<?php
$redis = new Redis();
$redis->connect('Redis的IP地址',6379);
$redis->set('test','hello docker_redis');
echo $redis->get('test');