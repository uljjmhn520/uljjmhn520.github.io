---
title: php-cli模式下使用apcu的问题
comments: true
share: true
toc: true
categories:
  - other
tags:
  - other
date: 2018-12-11 10:13:27
---


平时都是web模式下使用apc,最近在cli模式（swoole）下使用apcu的时候出现了问题。比如：设置了ttl，但不过期

<!-- more -->  

# apc和apcu

## apc

> The Alternative PHP Cache (APC) is a free and open opcode cache for PHP. Its goal is to provide a free, open, and robust framework for caching and optimizing PHP intermediate code.

apc的功能分为两部分

1. opcode缓存。貌似在php5.5之后，apc的某版本有内存问题，就被官方废弃了 
2. 数据缓存，可以存储k/v对，类似memcache

## apcu

可以认为是apc去掉opcode的阉割版，仅保留了数据缓存功能。php api接口完全和apc相同

# 安装

不多说了，网上一大堆。

在debian 下,一句代码的事情

```bash
apt-get install php5-apcu

apt-get install php7.0-apcu

apt-get install php7.1-apcu

apt-get install php7.2-apcu

apt-get install php7.3-apcu

apt-get install php7.4-apcu

apt-get install php7.7-apcu
```

# 配置
```text

apc.enabled= on
apc.shm_size= 64M
apc.enable_cli = on
apc.use_request_time = 0
......
```



# 坑在哪儿

## cli下不过期的问题

```php
apcu_add('foo','bar',5);
sleep(6);
echo apcu_fetch('foo');

# the result is bar

```

查了一下，是 **use_request_time** 的问题

> http://php.net/manual/zh/apcu.configuration.php#ini.apcu.use-request-time

```bash
# 在配置文件中改为0就行了
apc.use_request_time = 0
```


