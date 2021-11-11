---
title: 解决 nvm 无法在 arm 架构下安装 V15 以下的 node 版本 的问题
date: 2021-11-08 18:08:02
tags: 
    - 技术向
    - macOS
    - node
    - nvm 
thumbnail: https://i.loli.net/2021/11/08/vhZXDgKMU46aYiI.png
---
<!-- more -->
迫于需要维护公司一个比较老的项目，所以在配置 macOS 环境的时候选择了使用 `nvm` 来管理多个 `node`，但是根据 nvm 官方文档的说法：

>January 2021: there are no pre-compiled NodeJS binaries for versions prior to 15.x for Apple's new M1 chip (arm64 architecture).

也就是说 M1 芯片（ arm64 ）现在并没有对应的预编译版本，所以安装之后需要进行编译。而在编译过程中会遇到一些问题：

- 编译成功，但是因为内存不足而崩溃（ crashes ），增加足够的 node 内存后再次尝试但依然提示内存不足；
- 直接编译失败。

这里我遇到的是第二种情况，也就是直接编译失败。那么如何解决这个问题呢， nvm 其实在文档里给出了一个方案，这个方案有两个前提：
- 使用 `zsh`
- 已经安装好 Rosetta 2
macOS 应该在 macOS X 上的默认终端就已经是 `zsh` 了，而 Rosetta 2 如果在你第一次打开因特尔架构的软件时就已经安装过了，如果没有安装过也可以手动进行安装：
```zsh
softwareupdate --install-rosetta
```

以上两个条件都满足之后我们就可以处理这个问题了。

1. 首先检查自己的 `node` 架构，返回的结果应该是 `arm64`，这个是 M1 芯片的架构，也就是我们问题的~~元凶~~；
```node
node -p process.arch

# arm64
```
2. 在 64 位 x86 架构下启动一个新的 zsh 进程；
```zsh
arch -x86_64 zsh
```
3. 下载你需要的 node 版本，这个 node 将会是 x86 架构的；
```zsh
nvm install node
```
4. 现在检查一下架构是否正确；
```node
node -p process.arch

# x64
```
5. 退出这个进程。
```zsh
exit
```

到这里我们就成功的安装好了一个低版本的 node。