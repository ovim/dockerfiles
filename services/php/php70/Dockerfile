ARG PHP_VER
ARG COMPOSER_URL

# 镜像包
FROM php:${PHP_VER}

# 设置时区为上海
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Ubuntu软件源选择中国的服务器
# RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
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

# 安装PHP核心拓展
RUN docker-php-ext-install \
        pdo_mysql \
        opcache \
        mysqli \
        intl \
        exif \
        zip \
        bcmath \
	&& docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && rm -r /var/lib/apt/lists/*

#pecl安装redis扩展
RUN pecl install -o -f redis  \
    && rm -rf /tmp/pear

#redis加入php扩展
RUN cd /usr/local/etc/php \
    && cp php.ini-development php.ini \
    && echo "extension=redis.so" >> /usr/local/etc/php/php.ini

# 安装 Composer
# ENV COMPOSER_HOME /root/composer

# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# ENV PATH $COMPOSER_HOME/vendor/bin:$PATH

# RUN composer config -g repo.packagist composer ${COMPOSER_URL}

# RUN composer global require "fxp/composer-asset-plugin:^1.4.0"