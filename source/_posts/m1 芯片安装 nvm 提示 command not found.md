---
title: m1 芯片安装 nvm 提示 command not found
date: 2021-11-05 23:13:53
tags: 
    - nvm
---
最近新购入了一台 M1 的 MacBook Air，作为一个合格的程序员自然是先配置环境，但是没想到第一个安装的 nvm 上来就给了我当头一棒。
首先根据 [nvm](https://github.com/nvm-sh/nvm#manual-install)给出的文档下载：
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
```
下载完成，键入 `nvm` 测试一下是否成功，果不其然，报错：
```
command not found: nvm
```
那就看一下是哪里的问题吧，查了一下，似乎是没有 `.bash_profile` 这个文件造成的。

那好办，创建一个就完了：
```zsh
touch ~/.bash_profile
```
创建完根据文档的说法是需要再运行一次安装命令，之后 `source ~./bash_profile` 让配置生效即可。
> If you use bash, the previous default shell, your system may not have a .bash_profile file where the command is set up. Create one with `touch ~/.bash_profile` and run the install script again. Then, run `source ~/.bash_profile` to pick up the nvm command.

执行完上述操作后好像没什么问题了，那么试一下 `nvm`，ok 成功了。

***

似乎问题到这里就结束了，但很遗憾并没有。

在几分钟之后，我再次打开 Terminal 准备安装 node 的时候，习惯性先输入 `nvm`，这时候怪事发生了：
```
zsh: command not found: nvm
```
这是怎么回事呢，按照前面的再来一遍，正常了；重启 Terminal 输入 `nvm`， 报错。

试了好几次，都是一样的结果。这个时候就有点急了，这是怎么会事呢？翻来覆去查了好多资料也没结果，这个时候，文档上的一句话给了我提示：
>Since macOS 10.15, the default shell is zsh and nvm will look for `.zshrc` to update, none is installed by default. Create one with `touch ~/.zshrc` and run the install script again.
也就是说我现在使用的是 zsh 而不是 bash，所以 nvm 会寻找 `.zshrc`。那么这就好解决了：
```zsh
touch ～/.zshrc
```
运行安装命令，`vim .zshrc` 查看一下文件确实有写入，输入 `nvm` 也正常，再次重启 Terminal，一切 ok。

***
还是要仔细看文档，google 了一圈啥用没有，文档啥都写清楚了😅
