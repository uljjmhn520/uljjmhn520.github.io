---
title: 记一次npm的发布
comments: true
share: true
toc: true
categories:
  - develop
tags:
  - develop
  - node
  - js
date: 2019-07-20 09:46:37
---

开发这么多年了，重来没有发布过一款npm的包，今天试了一下

<!-- more -->  

# 开始

## 假如已有一个要发布的包，并在项目的根文件夹里

```bash
npm init
# 然后填入相关的信息


```


## 登录



```bash
npm login
```

如果该电脑上面没有 npm login 过则要先 adduser，貌似是这样

```bash
npm adduser
```


## 发布

```bash
npm publish
```


# 上travis自动发布

先转一个，后面稳定了，就上travis

> https://blog.csdn.net/lym152898/article/details/81868524