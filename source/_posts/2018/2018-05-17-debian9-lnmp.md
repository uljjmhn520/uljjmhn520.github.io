---
title: "debian9 安装 lnmp"
comments: true
share: true
toc: true
date: "2018-05-17 00:00:02"
categories:
  - develop

tags:
  - debian
  - php

---



从前blog移植过来，暂无摘要，后期再补

<!--more-->

# 更新源


## debian9
使用默认源

## debian8及以下
现在没怎么用debian8了，所以就不写了。

要么手工编译，要么直接 [oneinstack](https://oneinstack.com/)

## 更新本地
apt-get update

# 安装

```bash
apt-get install nginx mysql-server php7.0-fpm php7.0-curl php7.0-gd php7.0-intl php-pear php7.0-imagick php7.0-imap php7.0-mcrypt php7.0-common php7.0-mysql php7.0-pspell php7.0-recode php7.0-sqlite php7.0-dev php7.0-tidy php7.0-xmlrpc php7.0-xsl php7.0-memcached memcached
```
分行命令

```bash
apt-get install nginx mysql-server php7.0-fpm php7.0-curl \
php7.0-mbstring php7.0-intl php-pear php7.0-imagick php7.0-imap \
php7.0-mcrypt php7.0-common php7.0-mysql php7.0-pspell \
php7.0-recode php7.0-sqlite php7.0-dev php7.0-tidy php7.0-gd \
php7.0-xmlrpc php7.0-xsl php7.0-memcached memcached
```

