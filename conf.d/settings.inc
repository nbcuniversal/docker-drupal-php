<?php
$databases['default'] = array ('default' =>
  array (
    'database' => getenv('MYSQL_DATABASE'),
    'username' => getenv('MYSQL_USERNAME'),
    'password' => getenv('MYSQL_PASSWORD'),
    'host'     => getenv('MYSQL_HOSTNAME'),
    'port'     => '',
    'driver'   => 'mysql',
    'prefix'   => '',
  ),
);

$conf['file_temporary_path'] = '/tmp';

//$conf['redis_client_interface'] = 'PhpRedis';
//$conf['redis_client_host'] = getenv('REDIS_HOSTNAME');
//$conf['redis_client_port'] = getenv('REDIS_PORT');
//$conf['lock_inc'] = 'sites/all/modules/contrib/redis/redis.lock.inc';
//$conf['path_inc'] = 'sites/all/modules/contrib/redis/redis.path.inc';
//$conf['cache_backends'][] = 'sites/all/modules/contrib/redis/redis.autoload.inc';
//$conf['cache_prefix'] = getenv('REDIS_PREFIX');
//$conf['cache_default_class'] = 'Redis_Cache';
//$conf['cache_class_cache_form'] = 'DrupalDatabaseCache';
