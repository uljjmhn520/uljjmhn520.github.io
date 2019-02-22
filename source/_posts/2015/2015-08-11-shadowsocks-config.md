---
title: "shadowsocks常用配置"
comments: true
share: true
toc: true
date: "2015-08-11 00:00:01"
categories:
  - other

tags:
  - shadowsocks
  - fq

---

从前有一堵墙，后来我们翻了过去。

<!--more-->

# 安装
安装的方式有很多种，windows版的就不说了，无非一个双击或者cmd下执行二进制。下面说下linux的

## 源码编译

这个不多谈，去gayhub自己看

## 下载编译好的二进制文件

这个不多谈，去gayhub的releases自己看

## 用pip安装

以debian为例

```bash
apt-get install python-pip
pip install shadowsocks

```
## 其它

我写了一个简单的脚本用来简单的安装，基于shadowsocks-go 1.2.0

```bash
# 终端代码 

git clone https://github.com/uljjmhn555/ssinstaller

cd ssinstaller

./install

# 然后去 **/etc/shadowsocks** 编辑配置文件
cd /etc/shadowsocks

# 编辑配置文件略过，请看下文

# 启动
systemctl start sslocal|ssserver

# 开机自启动
systemctl enable sslocal|ssserver

```
  
# 配置

shadowsocks以json为配置文件格式，以下是一个样例：

```bash
{
    "server":"remote-shadowsocks-server-ip-addr",
    "server_port":443,
    "local_address":"127.0.0.1",
    "local_port":1080,
    "password":"your-passwd",
    "timeout":300,
    "method":"aes-256-cfb",
    "fast_open":false,
    "workers":1
}
```
    
提示: 若需同时指定多个服务端ip，可参考"server":["1.1.1.1","2.2.2.2"],



server	服务端监听地址(IPv4或IPv6)

server_port	服务端端口，一般为443

local_address	本地监听地址，缺省为127.0.0.1

local_port	本地监听端口，一般为1080

password	用以加密的密匙

timeout	超时时间（秒）

method	加密方法，默认的table是一种不安全的加密，此处首推aes-256-cfb

fast_open	是否启用TCP-Fast-Open

wokers	worker数量，如果不理解含义请不要改

## 客户端

在config.json所在目录下运行 **sslocal** 即可；若需指定配置文件的位置：

```bash

sslocal -c /etc/shadowsocks/config.json
# 注意: 有用户报告无法成功在运行时加载config.json，或可尝试手动运行：

sslocal -s 服务器地址 -p 服务器端口 -l 本地端端口 -k 密码 -m 加密方法
# 提示: 当然也有图形化的使用shadowsocks-gui@gitHub,如果不希望自己编译的话，也可以到shadowsocks-gui@sourceforge下载。
```

## 服务端

提示: 普通用户无需配置服务端；


在服务器上cd到config.json所在目录：


运行ssserver；


如果想在后台一直运行，可改执行：nohup ssserver > log &；


## 以守护进程形式运行客户端

Shadowsocks的systemd服务可在/etc/shadowsocks/里调用不同的conf-file.json（以conf-file为区分标志），例： 在/etc/shadowsocks/中创建了foo.json配置文件，那么执行以下语句就可以调用该配置：

```bash

systemctl start shadowsocks@foo
```
    
若需开机自启动：

```bash

systemctl enable shadowsocks@foo
```
    
提示: 可用journalctl -u shadowsocks@foo来查询日志；

## 以守护进程形式运行服务端
以上只是启动了客户端的守护进程，如果架设的是服务器，则需要：

```bash

systemctl start shadowsocks-server@foo
systemctl enable shadowsocks-server@foo
```
    
提示: 如果使用的服务端端口号小于1024，需要修改usr/lib/systemd/system/shadowsocks-server@.service使得user=root，之后使用systemctl daemon-reload重新载入守护进程配置，即可开启监听。

## 加密

注意: 默认加密方法table速度很快，但很不安全。推荐使用aes-256-cfb或者bf-cfb，照目前的趋势，ChaCha20是占用最小速度最快的一种方式。请不要使用rc4，它不安全。

提示: 安装M2Crypto可略微提升加密速度，对于Python2来说，安装python2-m2crypto即可。

可选的加密方式：

- aes-256-cfb: 默认加密方式

- aes-128-cfb

- aes-192-cfb

- aes-256-ofb

- aes-128-ofb

- aes-192-ofb

- aes-128-ctr

- aes-192-ctr

- aes-256-ctr

- aes-128-cfb8

- aes-192-cfb8

- aes-256-cfb8

- aes-128-cfb1

- aes-192-cfb1

- aes-256-cfb1

- bf-cfb

- camellia-128-cfb

- camellia-192-cfb

- camellia-256-cfb

- cast5-cfb

- chacha20

- idea-cfb

- rc2-cfb

- rc4-md5

- salsa20

- seed-cfb

注意: 官方软件源的shadowsocks不支持全部加密方式，官方软件源Chacha20以及salsa20的支持可以安装libsodium（For salsa20 and chacha20 support） 。若对非主流加密方式有需求，可尝试aur中的shadowsocks-nodejsAUR[broken link: archived in aur-mirror]



## Chrome/Chromium

至此，本地监听端口127.0.0.1:1080已配置完毕。现以Chrome/Chromium为例，示范使用代理服务器的方法。



请安装 Proxy SwitchyOmega插件（SwitchySharp已停止开发），若商店打不开的话可以直接下载Github上面的crx文件可参考该扩展提供的图解流程。



直接参考 SwitchySharp+shadowsocks-nodejs Windows 下配置介绍 的第二部分”设置浏览器代理扩展“即可。或者参考我的配置@2015.02.04文件即可，支持自动通过gfwlist自动切换。

# 服务器开启bbr

> 服务器内核版本要求 >=4.9

```bash
# 修改系统变量
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf

# 保存生效
sysctl -p

# 查看内核是否已开启BBR
sysctl net.ipv4.tcp_available_congestion_control

# 查看BBR是否启动
lsmod | grep bbr

# 显示以下，表示成功 （数字不一定一样）
#tcp_bbr                20480  14

```


# 服务器开启 tcp_fastopen

> 服务器内核版本要求 >= 3.7.1

```bash

echo "net.ipv4.tcp_fastopen=3" >> /etc/sysctl.conf && sysctl -p
```

# 最后

加一个链接，你懂的

https://autoproxy-gfwlist.googlecode.com/svn/trunk/gfwlist.txt

2016-06-24 上面的链接貌似不能用了。加一个

https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt

https://github.com/gfwlist/gfwlist

# 引用地址

> https://wiki.archlinux.org/index.php/Shadowsocks_%28%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87%29
> https://www.moerats.com/archives/297/