ARG NGINX_VER

FROM nginx:${NGINX_VER}

# 设置时区为上海
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 更换软件安装源
RUN sed -i 's@http://deb.debian.org@http://mirrors.aliyun.com@g' /etc/apt/sources.list

# 更新安装依赖包
RUN apt-get update && apt-get install -y \
        vim \
        wget

# 安装模块
unzip nginx-upstream-fair-master.zip #解压
mv nginx-upstream-fair-master nginx-upstream-fair #重命名

#配置
./configure \
--prefix=/usr/sbin/nginx \
--with-http_ssl_module \
--add-module=/root/nginx-upstream-fair
#编译安装
make && make install