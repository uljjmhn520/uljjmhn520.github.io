---
title: "linux 新用户不能tab自动补全、退格变^H 等问题"
comments: true
share: true
toc: true
date: "2016-07-29 00:00:01"
categories:
  - linux

tags:
  - linux

---



从前blog移植过来，暂无摘要，后期再补

<!--more-->

  


去年搞了台国外的便宜的服务器，主要用于浏览长城以外的风光。服务器也一直很稳定。

由于硬盘空间较小，也没有准备搞其它用。最近决定在服务器上搞一些不占空间的服务，我草，每个访问一个页面，后面都带一段js代码。

然后试了一下，就连这最简单的 “echo 'hello world';” 都会带。google 了一下，没找到原因，然后就一言不合的重装了系统。。。

然后新建用户，切换过后发现新用户有问题。比如退格键是 ^H ，tab键不自动补全。。。

用命令看了一下

    cat /ect/passwd

发现root用户的shell是/bin/bash

普通用户的shell是/bin/sh

然后把该用户的 /bin/sh 改成 /bin/bash 就行了


