---
title: Git 使用笔记
date: 2021-11-01 17:25:53
toc: true
cover: https://i.loli.net/2021/11/11/Yfq1o7FIGxaNip8.jpg
thumbnail: https://i.loli.net/2021/11/11/Yfq1o7FIGxaNip8.jpg
tags: 笔记
---

记一下不常用但是偶然还要用的 Git 指令。
<!--more-->

## 分支

- 列出所有分支  
`git branch` 

- 创建分支  
`git branch (branchname)`  
可以通过以下命令**创建**并**切换**到新分支  
`git checkout -b (branchname)`

- 切换分支  
`git checkout (branchname)` 

- 合并分支  
`git merge (the branchname you want merge to current branch)`

- 删除分支
- `git branch -d (branchname)`