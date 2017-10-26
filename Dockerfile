FROM php:7.0-fpm

RUN apt-get update && \
    apt-get install -y mysql-client \
                       libjpeg62-turbo-dev \
                       libpng12-dev \
                       libpq-dev \
                       libpng-dev \
                       unzip \
                       git \
                       imagemagick

# configure extensions
RUN docker-php-ext-configure gd --with-jpeg-dir=/usr --with-png-dir=/usr && \
    docker-php-ext-configure opcache --enable-opcache

# php extensions
RUN docker-php-ext-install gd \
                           mbstring \
                           opcache \
                           pdo \
                           pdo_mysql \
                           pdo_pgsql \
                           mysqli \
                           zip

# redis and cleanup
RUN pecl install redis && \
    echo 'extension=redis.so' >> /usr/local/etc/php/conf.d/redis.ini && \
    docker-php-ext-enable redis && \
    rm -fr /tmp/* /var/lib/apt/lists/* /var/tmp/* && \
    apt-get autoremove -y && \
    apt-get autoclean && \
    apt-get clean

# composer
RUN curl -sS https://getcomposer.org/installer | php && \
    chmod +x composer.phar && \
    mv composer.phar /usr/local/bin/composer

# drush
RUN /usr/local/bin/composer global require drush/drush && \
    ln -s /root/.composer/vendor/drush/drush/drush /usr/local/bin/drush

COPY ./conf.d/php.ini /usr/local/etc/php/
COPY ./conf.d/www.conf /usr/local/etc/php-fpm.d/
COPY ./conf.d/settings.inc /var/www/site-php/
COPY ./conf.d/opcache.ini /usr/local/etc/php/conf.d/

WORKDIR /app/docroot
