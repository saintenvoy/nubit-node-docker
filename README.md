## 目录

- [Nubit Node Docker Setup](#nubit-node-docker-setup)
  - [目录](#目录)
  - [先决条件](#先决条件)
  - [克隆存储库](#克隆存储库)
  - [构建 Docker 镜像](#构建-docker-镜像)
  - [运行 Docker 容器](#运行-docker-容器)
  - [管理 Nubit 节点](#管理-nubit-节点)
    - [查看节点状态](#查看节点状态)
    - [查看节点日志](#查看节点日志)
    - [获取钱包地址](#获取钱包地址)
    - [获取公钥](#获取公钥)
    - [导出助记词](#导出助记词)

## 先决条件

在开始之前，请确保您的系统上已安装以下软件：

- [Git](https://git-scm.com/)
- [Docker](https://www.docker.com/get-started)

## 克隆存储库

首先，克隆此项目的 GitHub 存储库：

```sh
git clone https://github.com/yourusername/nubit-node-docker.git
cd nubit-node-docker
```

## 构建 Docker 镜像
在克隆的存储库目录中运行以下命令来构建 Docker 镜像：

```sh

docker build -t nubit-node .
```
## 运行 Docker 容器
构建完成后，运行以下命令启动 Nubit 节点容器：

```sh
docker run -d --name nubit-node -p 26656:26656 -p 26657:26657 nubit-node
```
该命令将启动一个名为 nubit-node 的 Docker 容器，并将端口 26656 和 26657 映射到主机。

## 管理 Nubit 节点

### 查看节点状态
要查看节点的状态，您可以使用以下命令：

```sh

docker exec -it nubit-node pm2 list
```
### 查看节点日志
要查看节点的日志，使用以下命令：

```sh

docker exec -it nubit-node pm2 logs nubit-node
```

### 获取钱包地址
要获取钱包地址，使用以下命令：

```sh
docker exec -it nubit-node nubit state account-address --node.store /root/.nubit-light-nubit-alphatestnet-1
```
### 获取公钥
要获取公钥，使用以下命令：

```sh
docker exec -it nubit-node nkey list --p2p.network nubit-alphatestnet-1 --node.type light
```
### 导出助记词
要导出助记词，使用以下命令：

```sh
docker exec -it nubit-node cat /root/nubit-node/mnemonic.txt
```