---
title: linux基本安全
comments: true
share: true
toc: true
categories:
  - other
tags:
  - other
date: 2019-03-22 09:40:15
---

自己运营一个小网站，还是需要一些安全知识
<!-- more -->  

# hello world
## 本文引用

> https://blog.csdn.net/holmofy/article/details/70185358

> https://www.cnblogs.com/lcword/p/5912614.html

```bash
echo 'hello world'
```


# 查日志文件

## 日志文件默认的路径

* Redhat or Fedora Core:
    /var/log/secure
* Mandrake, FreeBSD or OpenBSD:
    /var/log/auth.log
* SuSE:
    /var/log/messages
* Mac OS X (v10.4 or greater):
    /private/var/log/asl.log
* Mac OS X (v10.3 or earlier):
    /private/var/log/system.log
* Debian:
    /var/log/auth.log

## /var/log/secure

```bash
# 统计登录的次数
grep "Failed password for invalid user" /var/log/secure | awk '{print $13}' | uniq -c | sort -nr | more
```

## /var/log/btmp

该日志是用二进制文件保存的，用lastb查看

```bash
lastb | awk '{print $3}' | sort | uniq -c | sort -nr
```


# 修改ssh配置

ssh服务端的配置一般在 **/etc/ssh/sshd_config**

## 修改默认端口

```bash
Port 42972   #ssh端口默认是22，改成不容易猜的，一般5位数
```

## 禁止root登录

```bash
PermitRootLogin no
```

## 强制证书登录

```bash
PasswordAuthentication no
RSAAuthentication yes       #秘钥认证
PubkeyAuthentication yes 

```

# 安全工具


## lynis

### 介绍

[gayhub](https://github.com/CISOfy/lynis)

### 使用

先上链接，以后整理
[参见这里](http://www.importnew.com/29048.html)
[以及这里](https://blog.csdn.net/qq_37865996/article/details/84112065)

最简单的，执行审计命令。然后查看后面的建议，跟据建议进行一下步操作

```bash
lynis audit system
```

## fail2ban

### 配置文件

fail2ban的配置文件在 **/etc/fail2ban/** 文件夹里面

```bash
ls /etc/fail2ban
```
大概会出现以下文件
action.d  fail2ban.conf  fail2ban.d  filter.d  jail.conf  jail.d  paths-common.conf  paths-debian.conf  paths-fedora.conf  paths-freebsd.conf  paths-opensuse.conf  paths-osx.conf

然后，我们先改 **jail** ，不过官方不建议修改该文件，而是让我们建一个同名的local文件，并在里面修改配置。如下：

```bash
touch jail.local
```

### 防ssh暴破

修改 jail.local 文件，加入以下

```bash
[ssh-iptables]
enabled  = true
filter   = sshd
action   = iptables[name=SSH, port=22, protocol=tcp]
logpath  = /var/log/secure
maxretry = 5
findtime  = 600
bantime = 1800
```

参数说明
* enabled： 是否开启
* filter： 过滤器，具体规则在 filter.d/ 里面看
    ```bash
    cat /etc/fail2ban/filter.d/ssh.conf
    ```
* action=iptables[name=SSH, port=22, protocol=tcp]
    port 按实际填，应该是填哪个端口就禁哪个端口，具体未知，也未测试
* logpath: ssh的日志路径，参见 [ssh日志路径](#查日志文件)
* maxretry： 最大尝试次数，超过则会被ban掉
* findtime： 查询时间，单位秒，即查询多少秒内的登录错误次数
* bantime： 非法IP封禁时间，单位秒，-1 代表永远封锁

### http服务器防恶意扫描

以nginx为例，filter里面有一个 nginx-botsearch.conf，就以这个过滤

修改 jail.local 文件，加入以下

```bash
[http-botsearch]
enabled = true
port = http
filter = nginx-botsearch
logpath = /path/to/access.log
maxretry = 100
findtime = 5
bantime = 600
action = iptables[name=HTTP,port=http,protocol=tcp]
```

[参见这里](https://www.cnblogs.com/wangxiaoqiangs/p/5630325.html)

[参见这里](https://blog.51cto.com/7938217/1652970)

[参见这里](https://www.jianshu.com/p/4fdec5794d08)


