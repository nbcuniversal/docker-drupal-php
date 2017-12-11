FROM php:7.0-fpm

RUN apt-get update && \
    apt-get install -y mysql-client \
                       libjpeg62-turbo-dev \
                       libpng12-dev \
                       libpq-dev \
                       libpng-dev \
                       unzip \
                       git \
                       imagemagick \
                       htop \
                       wget

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

# newrelic
ENV NR_INSTALL_SILENT=true
ENV NR_INSTALL_KEY=
RUN wget -O- https://download.newrelic.com/548C16BF.gpg | apt-key add - && \
   echo 'deb http://apt.newrelic.com/debian/ newrelic non-free' | tee /etc/apt/sources.list.d/newrelic.list && \
   apt-get update && \
   DEBIAN_FRONTEND=noninteractive apt-get -y install newrelic-php5

# redis and cleanup
RUN pecl install redis && \
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
COPY ./conf.d/entrypoint.sh /

WORKDIR /app/docroot

RUN ["chmod", "+x", "/entrypoint.sh"]
CMD ["/entrypoint.sh"]
