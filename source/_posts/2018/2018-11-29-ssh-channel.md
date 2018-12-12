---
title: ssh隧道
comments: true
share: true
toc: true
categories:
  - linux
tags:
  - ssh
  - linux
date: 2018-11-29 23:17:20
---

孤陋寡闻了，经常会用到的ssh。SSH是一种安全的传输协议，用在连接服务器上比较多。
平时，还会用到他的隧道转发功能，类似代理。
现在猛然发下，居然还能用于内网穿透，于是乎记录一下

<!-- more -->  

# 常用功能

```bash
ssh user@host [-p xxx]
```

# 内网穿透

**ssh -C -f -N -g -R listen_port:DST_Host:DST_port user@Tunnel_Host** 


# 隧道转发

**ssh -C -f -N -g -L listen_port:DST_Host:DST_port user@Tunnel_Host** 

```bash
# 比如我常用的转发mysql。我一般不用参数f，比较方便，不用的时候ctrl+c 就关了
autossh -N -o "ServerAliveInterval=60" -o "PubkeyAuthentication=yes" -o "ServerAliveCountMax 3" -o "PasswordAuthentication=no" -L 0.0.0.0:3306:127.0.0.1:3306 server_user@server_host -p server_port

```

# 配置参数

> 参见man. 

* -f 
    要求 ssh 在执行命令前退至后台. 它用于当 ssh 准备询问口令或密语, 但是用户希望它在后台进行. 该选项隐含了 -n 选项. 在远端机器上启动 X11 程序的推荐手法就是类似于 ssh -f host xterm 的命令.

* -C 
    要求进行数据压缩 (包括 stdin, stdout, stderr 以及转发 X11 和 TCP/IP 连接 的数据). 
    压缩算法和 gzip(1) 的一样, 协议第一版中, 压缩级别 “level” 用 CompressionLevel 选项控制. 
    压缩技术在 modem 线路或其他慢速连接上很有用, 但是在高速网络上反而 可能降低速度. 
    可以在配置文件中对每个主机单独设定这个参数. 另见 Compression 选项.

* -g 
    允许远端主机连接本地转发的端口. 注：这个参数我在实践中似乎始终不起作用。

-o option
    可以在这里给出某些选项, 格式和配置文件中的格式一样.  它用来设置那些没有命令行开关的选项.


* -N 
    不执行远程命令. 用于转发端口. (仅限协议第二版)

* -L 
    port:host:hostport 将本地机(客户机)的某个端口转发到远端指定机器的指定端口.  
    工作原理是这样的, 本地机器上分配了一个 socket 侦听 port 端口, 一旦这个端口上有了连接, 
    该连接就经过安全通道转发出去, 同时远程主机和 host 的 hostport 端口建立连接. 
    可以在配置文件中指定端口的转发. 只有 root 才能转发特权端口.  IPv6 地址用另一种格式说明: port/host/hostport


* -R 
    port:host:hostport 将远程主机(服务器)的某个端口转发到本地端指定机器的指定端口.  
    工作原理是这样的, 远程主机上分配了一个 socket 侦听 port 端口, 一旦这个端口上有了连接, 
    该连接就经过安全通道转向出去, 同时本地主机和 host 的hostport 端口建立连接. 
    可以在配置文件中指定端口的转发. 只有用 root 登录远程主机 才能转发特权端口. 
    IPv6 地址用另一种格式说明: port/host/hostport


# autossh




# 参考链接

> https://blog.csdn.net/zhaoyangkl2000/article/details/77961356

> https://blog.csdn.net/zhaoyangkl2000/article/details/77961356