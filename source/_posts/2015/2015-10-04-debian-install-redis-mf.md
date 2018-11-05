---
title: "[转]debian 编译安装redis"
comments: true
share: true
toc: true
date: "2015-10-04 00:00:03"
categories:
  - web

tags:
  - debian
  - redis

---



从前blog移植过来，暂无摘要，后期再补

<!--more-->

  

Debian系统自带的Redis版本为2.4，Ubuntu自带的版本为2.8，都不是最新的3.0.2版本，不得不自己手工编译。流程如下：


安装构建包

    sudo apt-get install build-essential

下载源码

到 Redis首页 下载最新版本的源码，当前版本为 3.0.2：http://download.redis.io/releases/redis-3.0.2.tar.gz

编译

万幸，Redis是纯C开发，也没依赖什么特殊的库，解压后直接编译即可。

    tar xvf redis-3.0.2.tar.gz
    cd redis-3.0.2
    make
    make test

安装

一般Linux下的软件在编译完之后都是用make install，但通常所谓的安装只是单纯的拷贝文件到PATH目录下，并没有把redis-server注册为系统服务。还好，我们用Debian/Ubuntu就是有特权！Redis提供了一个工具，在安装完毕之后可帮忙注册系统服务。
    
    sudo make install
    cd utils
    sudo ./install_server.sh
    
根据提示填写默认端口、日志路径、配置文件路径等，可惜没有让我们填写系统服务的名称，默认名称为 redis_6379，我还是喜欢服务名叫 redis-server，因此需要执行如下代码：

    sudo mv /etc/init.d/redis{_6379,-server}
    
这样通过 sudo service redis-server restart 就能管理Redis服务器了。

测试
    
    $ redis-cli PING
    PONG

> 引用地址：http://www.w2bc.com/Article/44498