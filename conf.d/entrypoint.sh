#!/bin/bash -e

# Drupal Docker PHP simple entrypoint script..

# Only enable New Relic on Production and Staging environments
if [ "$SITE_ENVIRONMENT" = "prod" ] || [ "$SITE_ENVIRONMENT" = "stg" ]
then
newrelic-install install

cat <<EOF > /usr/local/etc/php/conf.d/newrelic.ini
extension = "newrelic.so"
newrelic.license = ${NR_INSTALL_KEY}
newrelic.appname = ${SITE_IDENTIFIER}${SITE_ENVIRONMENT}
EOF

fi

# Start PHP FPM
exec php-fpm
