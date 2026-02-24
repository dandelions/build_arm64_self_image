# 使用 Ubuntu 22.04 作为基础镜像
FROM ubuntu:22.04

# 设置环境变量，避免交互式安装时的提示
ENV DEBIAN_FRONTEND=noninteractive

# 更新源并安装基础软件
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    vim \
    ca-certificates \
    unzip \
    build-essential \
    python3 \
    python3-pip \
    postgresql-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 2. 安装 Oracle Instant Client (以 21.x 版本为例)
# 自动检测架构 (AMD64 或 ARM64) 并下载对应的压缩包
RUN mkdir -p /opt/oracle && \
    ARCH=$(uname -m) && \
    if [ "$ARCH" = "x86_64" ]; then \
      URL="https://download.oracle.com"; \
    elif [ "$ARCH" = "aarch64" ]; then \
      URL="https://download.oracle.com"; \
    fi && \
    wget $URL -O /tmp/instantclient.zip && \
    unzip /tmp/instantclient.zip -d /opt/oracle && \
    mv /opt/oracle/instantclient_* /opt/oracle/instantclient && \
    rm -rf /tmp/instantclient.zip

# 安装 Python 第三方库
# 使用 psycopg2-binary 无需额外的编译依赖
RUN pip3 install --no-cache-dir \
    pymysql \
    psycopg2-binary \
    kafka-python \
    requests \
    cx_Oracle

# 设置默认工作目录
WORKDIR /root

# 验证安装
CMD ["/bin/bash"]
