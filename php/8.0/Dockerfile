FROM php:8.0-fpm

# 设置时区为上海
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 更换软件安装源
RUN sed -i 's@http://deb.debian.org@http://mirrors.aliyun.com@g' /etc/apt/sources.list

RUN apt-get update -y && \
    apt-get -y install gcc make autoconf libc-dev pkg-config libzip-dev && \
    # install required libs for health check
    apt-get -y install libfcgi0ldbl nano htop iotop lsof cron mariadb-client redis-tools wget && \
    apt-get install -y apt-transport-https locales gnupg && \
    # --no-install-recommends参数来避免安装非必须的文件，从而减小镜像的体积
    apt-get install -y --no-install-recommends \
	git \
    vim \
	libmemcached-dev \
	libz-dev \
	libpq-dev \
	libssl-dev libssl-doc libsasl2-dev \
	libmcrypt-dev \
	libxml2-dev \
	zlib1g-dev libicu-dev g++ \
	libldap2-dev libbz2-dev \
	curl libcurl4-openssl-dev \
	libgmp-dev firebird-dev libib-util \
	re2c libpng++-dev \
	libwebp-dev libjpeg-dev libjpeg62-turbo-dev libpng-dev libxpm-dev libvpx-dev libfreetype6-dev \
	libmagick++-dev \
	libmagickwand-dev \
	zlib1g-dev libgd-dev \
	libtidy-dev libxslt1-dev libmagic-dev libexif-dev file \
	sqlite3 libsqlite3-dev libxslt-dev \
	libmhash2 libmhash-dev libc-client-dev libkrb5-dev libssh2-1-dev \
	unzip libpcre3 libpcre3-dev \
	poppler-utils ghostscript libmagickwand-6.q16-dev libsnmp-dev libedit-dev libreadline6-dev libsodium-dev \
	freetds-bin freetds-dev freetds-common libct4 libsybdb5 tdsodbc libreadline-dev librecode-dev libpspell-dev libonig-dev && \
    # fix for docker-php-ext-install pdo_dblib
    # https://stackoverflow.com/questions/43617752/docker-php-and-freetds-cannot-find-freetds-in-know-installation-directories
    ln -s /usr/lib/x86_64-linux-gnu/libsybdb.so /usr/lib/ && \
    docker-php-ext-install pdo_dblib

RUN docker-php-ext-install bcmath bz2 calendar ctype curl dba dom && \
    docker-php-ext-install fileinfo exif ftp gettext gmp && \
    docker-php-ext-install intl ldap mbstring mysqli && \
    docker-php-ext-install opcache pcntl pspell && \
    docker-php-ext-install pdo_mysql pdo_pgsql pdo_sqlite pgsql phar posix && \
    docker-php-ext-install session shmop simplexml soap sockets sodium && \
    docker-php-ext-install sysvmsg sysvsem sysvshm && \
    docker-php-ext-install snmp && \
    docker-php-ext-install xml xsl && \
    docker-php-ext-install tidy tokenizer zend_test zip && \
    docker-php-ext-install filter && \
    docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
	docker-php-ext-install imap iconv && \
    # 安装GD
    docker-php-ext-configure gd \
	--with-jpeg \
	--with-xpm \
	--with-webp \
	--with-freetype \
	&& docker-php-ext-install -j$(nproc) gd

# install pecl extension
RUN pecl install ds && \
	pecl install imagick && \
	pecl install igbinary && \
    pecl install memcache-4.0.5.2 && \
	pecl install memcached && \
	pecl install mcrypt && \
    pecl install mongodb && \
    pecl install redis-5.3.7 && \
    pecl install swoole-5.0.0 && \
	docker-php-ext-enable ds imagick igbinary memcache memcached mongodb redis swoole && \
    # install APCu
    pecl install apcu && \
	docker-php-ext-enable apcu --ini-name docker-php-ext-10-apcu.ini && \
    # install xdebug
    pecl install xdebug && docker-php-ext-enable xdebug && \
    # install msgpack
    yes "" | pecl install msgpack && \
	docker-php-ext-enable msgpack

# install composer
RUN EXPECTED_CHECKSUM="$(wget -q -O - https://composer.github.io/installer.sig)" && \
	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
	ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")" && \
	if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]; then >&2 echo 'ERROR: Invalid installer checksum' && exit 1; fi && \
    php composer-setup.php --quiet && rm composer-setup.php && \
	mv composer.phar /usr/local/sbin/composer && \
	chmod +x /usr/local/sbin/composer

# install MSSQL support and ODBC driver
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
	curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
	apt-get update -y && \
	ACCEPT_EULA=Y apt-get install -y msodbcsql18 mssql-tools18 && \
	apt-get install -y unixodbc-dev libgssapi-krb5-2 && \
    # MSSQL extension
    set -xe \
	&& pecl install pdo_sqlsrv \
	&& docker-php-ext-enable pdo_sqlsrv \
	&& pecl install sqlsrv \
	&& docker-php-ext-enable sqlsrv \
	&& apt-get purge -y unixodbc-dev && apt-get autoremove -y && apt-get clean

# RUN docker-php-ext-configure spl && docker-php-ext-install spl

#--------------------------------------------------------------------------
# Final Touches
#--------------------------------------------------------------------------
# install NewRelic agent
RUN echo 'deb [trusted=yes] http://apt.newrelic.com/debian/ newrelic non-free' | tee /etc/apt/sources.list.d/newrelic.list && \
	curl https://download.newrelic.com/548C16BF.gpg | apt-key add - && \
	apt-get -y update && \
	DEBIAN_FRONTEND=noninteractive apt-get -y install newrelic-php5 newrelic-sysmond && \
	export NR_INSTALL_SILENT=1 && newrelic-install install

# # install SendGrid
RUN echo "postfix postfix/mailname string localhost" | debconf-set-selections && \
	echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections && \
	DEBIAN_FRONTEND=noninteractive apt-get install postfix libsasl2-modules -y

# Health check
RUN echo '#!/bin/bash' > /healthcheck && \
	echo 'env -i SCRIPT_NAME=/health SCRIPT_FILENAME=/health REQUEST_METHOD=GET cgi-fcgi -bind -connect 127.0.0.1:9000 || exit 1' >> /healthcheck && \
	chmod +x /healthcheck

# set locale to utf-8
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

# Set default work directory
ADD scripts/* /usr/local/bin/
RUN chmod +x  /usr/local/bin/*

# Add default configuration files
ADD configs/php.ini /usr/local/etc/php/
ADD configs/www.conf /usr/local/etc/php-fpm.d/

# Clean up
# RUN apt-get remove -y git && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# 更换软件安装源
RUN sed -i 's@http://mirrors.aliyun.com@http://deb.debian.org@g' /etc/apt/sources.list

WORKDIR /
