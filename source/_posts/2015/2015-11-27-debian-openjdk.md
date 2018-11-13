---
title: "debian安装Openjdk7"
comments: true
share: true
toc: true
date: "2015-11-27 00:00:01"
categories:
  - other

tags:
  - debian
  - openjdk
  - java

---



从前blog移植过来，暂无摘要，后期再补

<!--more-->

  

在命令行中，键入：

    apt-get install openjdk-7-jre


需要注意的是，openjdk-7-jre包只包含Java运行时环境（Java Runtime Environment）。如果是要开发Java应用程序，则需要安装openjdk-7-jdk包。命令如下：

    apt-get install openjdk-7-jdk