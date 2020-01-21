FROM php:7.4.1-fpm

COPY install-composer.sh /
RUN apt-get update \
    && apt-get install -y wget git unzip libpq-dev \
    && : 'Install Node.js' \
    &&  curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get install -y nodejs \
    && : 'Install PHP Extensions' \
    && docker-php-ext-install -j$(nproc) pdo_pgsql \
    && : 'Install Composer' \
    && chmod 755 /install-composer.sh \
    && /install-composer.sh \
    && mv composer.phar /usr/local/bin/composer

RUN apt-get update && apt-get install -y \
    libfreetype6-dev \

    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libjpeg-dev \
    zlib1g-dev \
    libxml2-dev \
    libzip-dev \
    libonig-dev \
    graphviz \

    && docker-php-ext-configure gd --with-jpeg=/usr/include/ --with-freetype=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install zip \
    && docker-php-source delete

WORKDIR /var/www/html/vuesplash