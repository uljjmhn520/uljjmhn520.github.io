---
title: "debian 安装phpredis 扩展"
comments: true
share: true
toc: true
date: "2015-10-04 00:00:01"
categories:
  - develop

tags:
  - debian
  - redis
  - php

---



从前blog移植过来，暂无摘要，后期再补

<!--more-->

  

1 安装redis server 


    sudo apt-get install redis-server


2 没有安装phpize ，需要安装php5-dev


    sudo apt-get install php5-dev


3 安装phpredis


    https://github.com/nicolasff/phpredis


下载并解压到。我解压到/home/len/soft/nicolasff-phpredis-1d6133d/


cd 到该目录，依次执行

    
    phpize5
    
    ./configure
    
    make
    
    make install(没权限时加上 sudo)
    

4 配置php.ini


我安装的是apache


创建 /etc/php5/apache2/conf.d/redis.ini


添加 extension=redis.so


5 重启apache  sudo apache2ctl restart


查看phpinfo().确认是否安装成功



以下为自己写的

如果步骤1报错，可以[点击此方法](/web/2015/10/debian-install-redis-mf)安装 redis-server



> 引用地址：http://blog.csdn.net/liangpz521/article/details/7822811