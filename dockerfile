# 使用官方的 Ubuntu 基础镜像
FROM ubuntu:22.04

# 设置环境变量以避免交互式配置
ENV DEBIAN_FRONTEND=noninteractive

# 更新包列表并安装必要的软件
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    build-essential \
    tar \
    bash \
    git \
    && apt-get clean

# 安装 Node.js 和 npm
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs

# 安装 PM2
RUN npm install pm2@latest -g

# 创建必要的目录
RUN mkdir -p /usr/src/app /root/nubit-node /root/logs

# 设置工作目录
WORKDIR /usr/src/app

# 下载并安装 Nubit 节点
RUN cd /root \
    && ARCH_STRING="linux-x86_64" \
    && MD5_NUBIT="650608532ccf622fb633acbd0a754686" \
    && MD5_NKEY="d474f576ad916a3700644c88c4bc4f6c" \
    && FOLDER=nubit-node \
    && FILE=$FOLDER-$ARCH_STRING.tar \
    && URL=http://nubit.sh/nubit-bin/$FILE \
    && curl -sLO $URL \
    && tar -xvf $FILE \
    && mkdir -p $FOLDER/bin \
    && mv $FOLDER-$ARCH_STRING/bin/nubit $FOLDER/bin/nubit \
    && mv $FOLDER-$ARCH_STRING/bin/nkey $FOLDER/bin/nkey \
    && rm -rf $FOLDER-$ARCH_STRING \
    && rm $FILE \
    && cp $FOLDER/bin/nubit /usr/local/bin \
    && cp $FOLDER/bin/nkey /usr/local/bin

# 复制 PM2 配置文件
COPY ecosystem.config.js /root/nubit-node/ecosystem.config.js

# 复制启动脚本
RUN curl -sL1 https://nubit.sh/start.sh -o /root/nubit-node/start.sh \
    && chmod +x /root/nubit-node/start.sh

# 设置环境变量
ENV store=/root/.nubit-light-nubit-alphatestnet-1

# 暴露 Nubit 节点使用的端口（假设使用默认端口）
EXPOSE 26656 26657

# 启动 Nubit 节点
CMD ["pm2-runtime", "start", "/root/nubit-node/ecosystem.config.js"]