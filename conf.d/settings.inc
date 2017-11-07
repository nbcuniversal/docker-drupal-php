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

$conf['file_temporary_path'] = 'sites/default/tmp';
