ARG MONGODB_VER

FROM mongo:${MONGODB_VER}

# 设置时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 更换软件安装源
RUN sed -i 's@http://deb.debian.org@http://mirrors.aliyun.com@g' /etc/apt/sources.list

RUN apt-get update -y && \
    vim wget

# COPY mongod.conf /etc/mongo/mongod.conf
# CMD ["mongod", "-f", "/etc/mongo/mongod.conf"]