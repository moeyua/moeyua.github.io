---
title: Git 使用笔记
date: 2021-11-01 17:25:53
tags: Git
categories: 笔记
---

记一下不常用但是偶尔还要用的 Git 指令。
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
 
 `git branch -d (branchname)`
 
- 提交新建的分支
 `git push --set-upstream origin (branchname)`

## 提交

- 撤回上次提交（commit）
 `git reset --soft HEAD^`

## 本地库文件操作

- 将修改存入新的临时存储
`git stash`
- 恢复上一次的临时存储（将会删除临时存储）
`git stash pop`