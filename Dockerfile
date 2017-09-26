FROM php:7.0-fpm

COPY ./conf.d/php.ini /etc/php/7.0/fpm/php.ini
COPY ./conf.d/www.conf /etc/php-fpm.d/www.conf
COPY ./conf.d/settings.inc /var/www/site-php/settings.inc

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
    echo 'extension=redis.so' >> /etc/php/7.0/fpm/php.ini && \
    curl -sS https://getcomposer.org/installer | php && \
    chmod +x composer.phar && \
    mv composer.phar /usr/local/bin/composer && \
    /usr/local/bin/composer global require drush/drush && \
    ln -s /root/.composer/vendor/drush/drush/drush /usr/local/bin/drush

WORKDIR /app/docroot
