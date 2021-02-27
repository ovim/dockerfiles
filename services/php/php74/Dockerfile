FROM php:7.4-fpm
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd 

RUN apt-get install -y --no-install-recommends libzip-dev && \
        rm -r /var/lib/apt/lists/* && \
        docker-php-ext-install -j$(nproc) zip pdo_mysql mysqli
