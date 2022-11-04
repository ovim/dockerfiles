<?php
ini_set('display_errors', 'On');

$redis = new Redis();
$redis->connect('172.172.0.3',6379);
$redis->auth('cloud@redis');
$redis->set('test','hello docker_redis');
echo $redis->get('test');
