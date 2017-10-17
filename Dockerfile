FROM php:7.0-fpm

COPY ./conf.d/php.ini /usr/local/etc/php/
COPY ./conf.d/www.conf /usr/local/etc/php-fpm.d/
COPY ./conf.d/settings.inc /var/www/site-php/

RUN apt-get update && \
    apt-get install -y mysql-client \
                       libjpeg62-turbo-dev \
                       libpng12-dev \
                       libpq-dev \
                       libpng-dev \
                       unzip \
                       git \
                       imagemagick && \
    docker-php-ext-configure gd \
      --with-jpeg-dir=/usr \
      --with-png-dir=/usr && \
    docker-php-ext-install gd \
                           mbstring \
                           pdo \
                           pdo_mysql \
                           pdo_pgsql \
                           mysqli \
                           zip && \
    pecl install redis && \
    echo 'extension=redis.so' >> /usr/local/etc/php/php.ini && \
    docker-php-ext-enable redis && \
    curl -sS https://getcomposer.org/installer | php && \
    chmod +x composer.phar && \
    mv composer.phar /usr/local/bin/composer && \
    /usr/local/bin/composer global require drush/drush && \
    ln -s /root/.composer/vendor/drush/drush/drush /usr/local/bin/drush

WORKDIR /app/docroot
