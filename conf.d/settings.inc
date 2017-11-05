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

// Set New Relic app name
if (extension_loaded('newrelic')) {
  $site_name = getenv('SITE_IDENTIFIER', true) ?: "dimpl";
  $site_env  = getenv('SITE_ENVIRONMENT', true) ?: "local";

  if ($site_env === "prod") {
    newrelic_set_appname($site_name . $site_env, "", true);
  }
}

$conf['file_temporary_path'] = '/tmp';
