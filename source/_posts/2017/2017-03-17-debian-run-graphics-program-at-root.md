---
layout: post
title: "debian 以root权限运行图形程序"
description: ""
date: "2017-03-17 00:00:01"
categories:
  - linux
tags:
  - sudo
  - debian
---
从前blog移植过来，暂无摘要，后期再补
<!-- more -->  

* #### 以 root 权限登录图形界面百度谷哥一大堆，就不写了，而且一般也用不着

* #### 最近遇到一个问题，运行一个图形程序，需要 root 权限。要按平常，直接 sudo 之。

        sudo xxx

* #### 拿 wireshark 来说，

        sudo wireshark

* #### 结果，报错了。。。

    不同的程序报错信息不同，但大致意思都是连不上 X。wireshark 报错如下

        No protocol specified

        ** (wireshark:20909): WARNING **: Could not open X display
        No protocol specified
        Unable to init server: 无法连接：拒绝连接

        (wireshark:20909): Gtk-WARNING **: cannot open display: :0

    某java 程序的报错如下

        No protocol specified
        Exception in thread "main" java.awt.AWTError: Can't connect to X11 window server using ':0' as the value of the DISPLAY variable.
                at sun.awt.X11GraphicsEnvironment.initDisplay(Native Method)
                at sun.awt.X11GraphicsEnvironment.access$200(X11GraphicsEnvironment.java:65)
                at sun.awt.X11GraphicsEnvironment$1.run(X11GraphicsEnvironment.java:115)
                at java.security.AccessController.doPrivileged(Native Method)
                at sun.awt.X11GraphicsEnvironment.<clinit>(X11GraphicsEnvironment.java:74)
                at java.lang.Class.forName0(Native Method)
                at java.lang.Class.forName(Class.java:264)
                at java.awt.GraphicsEnvironment.createGE(GraphicsEnvironment.java:103)
                at java.awt.GraphicsEnvironment.getLocalGraphicsEnvironment(GraphicsEnvironment.java:82)
                at java.awt.Window.initGC(Window.java:475)
                at java.awt.Window.init(Window.java:495)
                at java.awt.Window.<init>(Window.java:537)
                at java.awt.Frame.<init>(Frame.java:420)
                at java.awt.Frame.<init>(Frame.java:385)
                at javax.swing.JFrame.<init>(JFrame.java:189)
                at net.fs.client.ClientUI.<init>(ClientUI.java:167)
                at net.fs.client.FSClient.main(FSClient.java:26)


* #### 查了一下，图形界面有自己的 sudo

        #kde
        kdesudo COMMAND


        #gnome
        gksu COMMAND

        #COMMAND 里有参数时记得加上引号，将命令和参数包起来，如

        kdesudo 'godie -a --bcd=efg'

* #### 目前我是kde环境，试了一下，果然能用

        kdesudo wireshark

* ### ok 收工