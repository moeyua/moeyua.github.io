---
title: 使用 Homebrew 安装 Typora 的 0.11.18 版本
desc: blog html css javascript js vue macOS 前端 frontEnd
tags:
  - Homebrew
  - Typora
date: 2022-06-27 18:45:39
categories: 技术文档
---

[Typora](https://typora.io/) 虽然现在已经变成付费制软件，但是官方还是保持 `1.0` 版本之前的版本为免费应用，~~而且还把下载链接藏了起来~~。
虽然我们依然能够从官网下载到最后一个免费版本 `0.11.18`，但是~~程序员~~我们可能还不仅限于此，习惯使用 [Homebrew](https://brew.sh/) 的人更倾向于使用 Homebrew 来管理自己的大部分软件。手快的同学可能已经发现 Homebrew 上根本找不到旧版本的 Typora 包。
这里我就记录一下如何使用 Homebrew 下载 Typora，改方法理论上同样适用于其他 Homebrew 不提供的旧版本软件。

> 被官方藏了起来的下载链接：[Typora-0.11.18.dmg](https://download.typora.io/mac/Typora-0.11.18.dmg)，懒得折腾的同学可以直接下载安装。

1. 查看一下 Typora 的信息 `brew info typora`：

```bash
➜ brew info typora
typora: 1.3.7 (auto_updates)
https://typora.io/
Not installed
From: https://github.com/Homebrew/homebrew-cask/blob/HEAD/Casks/typora.rb
==> Name
Typora
==> Description
Configurable document editor that supports Markdown
==> Artifacts
Typora.app (App)
==> Analytics
install: 715 (30 days), 1,947 (90 days), 14,205 (365 days)
```

`From: https://github.com/Homebrew/homebrew-cask/blob/HEAD/Casks/typora.rb`
这里给我们提供了 Typora 的下载脚本地址，我们直接访问这个地址。

2. 查看这个脚本的历史提交记录：
   ![image-20220624125205567](https://s2.loli.net/2022/06/24/AyiVRpknjxhstme.png)

3. 找到我们需要的历史提交版本
   ![image-20220624125303673](https://s2.loli.net/2022/06/24/BbFqy1Ym9ZAHGjk.png)

4. 下载这个文件
   ![image-20220624125408151](https://s2.loli.net/2022/06/24/aUF2j4tGSpPhH7x.png)
   ![image-20220624125452425](https://s2.loli.net/2022/06/24/qhBYVtW3RK96pQN.png)

网页右键选择「另存为/储存为」，将这个文件保存到本地

6. 用任意的文本编辑器，例如「记事本」/「文本编辑」或者 IDE 将 URL 修改为官网提供的地址：`https://download.typora.io/mac/Typora-0.11.18.dmg`
   ![image-20220624125819271](https://s2.loli.net/2022/06/24/qVvchCR5eSZAEKN.png)

7. 执行 `brew install {下载的文件路径} --cask`

   ```bash
   ➜ brew install ./Downloads/typora.rb --cask
   ==> Downloading https://download.typora.io/mac/Typora-0.11.18.dmg
   ######################################################################## 100.0%
   ==> Installing Cask typora
   ==> Moving App 'Typora.app' to '/Applications/Typora.app'
   🍺  typora was successfully installed!
   ```

   