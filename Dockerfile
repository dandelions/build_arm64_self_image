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
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 设置默认工作目录
WORKDIR /root

# 验证安装
CMD ["/bin/bash"]
