#!/bin/bash -e

# Drupal Docker PHP simple entrypoint script..

# TODO: Disable NewRelic plugin on anything outisde STG/PROD.

# Add our NewRelic API key from NR_KEY env variable.
echo "newrelic.license=\"${NR_INSTALL_KEY}\"" >> /usr/local/etc/php/conf.d/newrelic.ini

# Start PHP FPM
exec php-fpm
