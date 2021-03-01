FROM php:7.4-fpm
ARG COMPOSER_URL

# 设置时区为上海
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 更换软件安装源
RUN sed -i 's@http://deb.debian.org@http://mirrors.aliyun.com@g' /etc/apt/sources.list

# 更新安装依赖包
RUN apt-get update && apt-get install -y \
        git \
        vim \
        curl \
        wget \
        openssl \
        imagemagick \
        libmagickwand-dev \
        libmagickcore-dev \
        libzip-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libxml2-dev \
		libssl-dev \
		librabbitmq-dev
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd 

RUN apt-get install -y --no-install-recommends libzip-dev && \
        rm -r /var/lib/apt/lists/* && \
        docker-php-ext-install -j$(nproc) zip pdo_mysql mysqli

# 安装PHP核心拓展
RUN docker-php-ext-install \
        opcache \
        intl \
        exif \
        bcmath \

# 安装 Composer
ENV COMPOSER_HOME /root/composer

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
ENV PATH $COMPOSER_HOME/vendor/bin:$PATH

RUN composer config -g repo.packagist composer ${COMPOSER_URL}

RUN composer global require "fxp/composer-asset-plugin:^1.4.0"