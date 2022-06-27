---
title: 从零开始的 RSSHub Docker 私有化部署指南
desc: blog html css javascript js vue macOS 前端 frontEnd
tags:
  - RSSHub
  - Docker
  - RSS
date: 2022-06-27 19:16:52
summary: 使用 RSSHub 也已经很长一段时间了，慢慢萌生了尝试一下自己部署 RSSHub 的想法，能够进行一些自定义的内容，也可以解决许多国内网站反爬严格的问题。部署过程还算顺利，这里做一个记录。
categories: 技术文档
---

使用 RSSHub 也已经很长一段时间了，慢慢萌生了尝试一下自己部署 RSSHub 的想法，能够进行一些自定义的内容，也可以解决许多国内网站反爬严格的问题。部署过程还算顺利，这里做一个记录。

#### 安装 Docker

1. 安装 `yum-utils`：

   ```bash
   sudo yum install -y yum-utils
   
   sudo yum-config-manager \
       --add-repo \
       https://download.docker.com/linux/centos/docker-ce.repo
   
   ```

2. 安装 `Docker Engine`：

   ```bash
   sudo yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin
   ```

3. 启动 Docker：

   ```bash
   sudo systemctl start docker
   ```

4. 确认 Docker 安装正确：

   ```bash
   sudo docker run hello-world
   ```

   这个命令下载了一个测试镜像，并在一个容器中运行它。当容器运行时，它会打印一条信息并退出。

5. 设置 Docker 开机启动

   ```bash
   sudo systemctl enable docker
   ```

   

##### 安装 Docker Compose

1. 下载 Docker Compose 的当前稳定版本：


   ```bash
sudo curl -L "https://github.com/docker/compose/releases/download/v2.2.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   ```

2. 将可执行权限应用于二进制文件：

   ```bash
   sudo chmod +x /usr/local/bin/docker-compose
   ```

3. 检查版本：

   ```bash
   docker-compose --version
   ```

#### 部署 RSSHub

1. 下载 [docker-compose.yml](https://github.com/DIYgod/RSSHub/blob/master/docker-compose.yml)

   ```bash
   wget https://raw.githubusercontent.com/DIYgod/RSSHub/master/docker-compose.yml
   ```

2. 检查有无需要修改的配置

   ```bash
   vi docker-compose.yml
   ```

3. 创建 volume 持久化 Redis 缓存

   ```bash
   docker volume create redis-data
   ```

4. 启动

   ```bash
   docker-compose up -d
   ```



#### 开放服务器端口

`docker-compose.yml` 文件中配置的端口号默认为 1200，需要在服务器上开启对应的端口号，使用时只需要将  https://rsshub.app/twitter/user/evodmoeyua  中的 `https://rsshub.app` 替换为  `http://yourip:1200`。


