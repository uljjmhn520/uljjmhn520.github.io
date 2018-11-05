---
layout: post
title: "debian 的 iptables 的常用配置"
description: ""
category : "@linux"
date: "2017-03-22 00:00:01"
tags: [ linux , iptables ,config ]
---
从前blog移植过来，暂无摘要，后期再补
<!-- more -->  


## 常用配置（转自 [http://www.cnblogs.com/kgdxpr/p/4061646.html]()）
### 第一次配置

    #这个一定要先做，不然清空后可能会悲剧
    iptables -P INPUT ACCEPT
    
    #清空默认所有规则
    iptables -F
    
    #清空自定义的所有规则
    iptables -X
    
    #计数器置0
     iptables -Z

### 配置规则

    #如果没有此规则，你将不能通过127.0.0.1访问本地服务，例如ping 127.0.0.1
    iptables -A INPUT -i lo -j ACCEPT

    #开启ssh端口22
    iptables -A INPUT -p tcp --dport 22 -j ACCEPT

    #开启FTP端口21
    iptables -A INPUT -p tcp --dport 21 -j ACCEPT
    
    #允许特定ip连接25端口：
    iptables -I FORWARD -s 127.0.0.1 -p tcp --dport 25 -j ACCEPT

    #开启web服务端口80
    iptables -A INPUT -p tcp --dport 80 -j ACCEPT

    #tomcat
    iptables -A INPUT -p tcp --dport 8080 -j ACCEPT

    #mysql
    iptables -A INPUT -p tcp --dport xxxx -j ACCEPT

    #允许icmp包通过,也就是允许ping
    iptables -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT

    #允许所有对外请求的返回包
    #本机对外请求相当于OUTPUT,对于返回数据包必须接收啊，这相当于INPUT了
    iptables -A INPUT -m state --state ESTABLISHED -j ACCEPT

    #如果要添加内网ip信任（接受其所有TCP请求）
    iptables -A INPUT -p tcp -s 45.96.174.68 -j ACCEPT

    #每秒中最多允许5个新连接
    iptables -A FORWARD -p tcp --syn -m limit --limit 1/s --limit-burst 5 -j ACCEPT

    #每秒中最多允许5个新连接
    iptables -A FORWARD -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s -j ACCEPT

    #Ping洪水攻击
    iptables -A FORWARD -p icmp --icmp-type echo-request -m limit --limit 1/s -j ACCEPT

    #封单个IP的命令是：
    iptables -I INPUT -s 222.34.135.106 -j DROP

    #封IP段的命令是：
    iptables -I INPUT -s 211.1.0.0/16 -j DROP
    iptables -I INPUT -s 211.2.0.0/16 -j DROP
    iptables -I INPUT -s 211.3.0.0/16 -j DROP

    #封整个段的命令是：
    iptables -I INPUT -s 211.0.0.0/8 -j DROP

    #封几个段的命令是：
    iptables -I INPUT -s 61.37.80.0/24 -j DROP
    iptables -I INPUT -s 61.37.81.0/24 -j DROP

    #过滤所有非以上规则的请求
    iptables -P INPUT DROP

###  保存重启

    #rehat
    service iptables save
    service iptables restart

    #debian
    iptables-save > /path/to/rulefile

###  删除规则1

    #eg，删除之前添加的规则 (iptables -A INPUT -p tcp -m tcp --dport 8080 -j ACCEPT)

    iptables -D INPUT -p tcp -m tcp --dport 8080 -j ACCEPT

### 删除规则2

    #列出指定的链的规则的编号
    iptables -L INPUT --line-numbers

    #删除第一条
    iptables -D INPUT 1

## debian的自动加载 (转自 [http://blog.phiy.me/debian-iptables-persistent/]())

### 安装 iptables-persistent

    apt-get install iptables-persistent

### 保存至 /etc/iptables/rules

    iptables-save > /etc/iptables/rules


http://www.cnblogs.com/kgdxpr/p/4061646.html

http://blog.phiy.me/debian-iptables-persistent/