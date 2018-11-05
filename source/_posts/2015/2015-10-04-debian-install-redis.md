---
title: "debian 安装并启动redis"
comments: true
share: true
toc: true
date: "2015-10-04 00:00:02"
categories:
  - web

tags:
  - debian
  - redis

---



从前blog移植过来，暂无摘要，后期再补

<!--more-->

  

安装

    $ apt-get install redis-server
    
最后一步启动的时候可能会出错，先不用理他，执行以下语句

    $ cp /etc/redis/redis.comf /etc/redis/redis.conf.default
    
启动并加载配置文件

    $ redis-server /etc/redis/redis.conf
    
测试

    $ redis-cli
    redis> set foo bar
    OK
    redis> get foo
    "bar"
    
完工

