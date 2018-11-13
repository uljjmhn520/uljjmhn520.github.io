---
title: Git用法总结
comments: true
share: true
toc: true
categories:
  - git
tags:
  - git
  - other
date: 2018-11-12 11:18:05
---

毫无疑问，Git是当下最流行、最好用的版本控制系统
<!-- more -->  

# 常用功能

## 先放一个链接
[https://blog.csdn.net/h247263402/article/details/74849182]()

# 非常用功能

## 导出diff 的文件
- 场景
  - 用php做了一个局域网的项目
  - 没有外网，更新还要用u盘
  - 需求在不断的改，改完就去跑去现场更新代码
  - 开始是把整个项目拷下来，用rsync同步代码
  - 直到一次不小心把config文件覆盖了
- 解决
  git的导出diff的文件

  > https://stackoverflow.com/questions/4541300/export-only-modified-and-added-files-with-folder-structure-in-git

  
  以下:

  Below commands worked for me.

  If you want difference of the files changed by the last commit:

  ```bash
  git archive -o /path/to/file.zip HEAD $(git diff --name-only HEAD^)
  ```
  or if you want difference between two specific commits:

  ```bash
  git archive -o update.zip 4d50f1ee78bf3ab4dd8e66a1e230a64b62c49d42 $(git diff --name-only 07a698fa9e5af8d730a8c33e5b5e8eada5e0f400)
  ```
  or if you have uncommitted files, remember git way is to commit everything, branches are cheap:

  ```bash
  git stash
  git checkout -b feature/new-feature
  git stash apply
  git add --all
  git commit -m 'commit message here'
  git archive -o update.zip HEAD $(git diff --name-only HEAD^)
  ```
  


# 其它

目前没有