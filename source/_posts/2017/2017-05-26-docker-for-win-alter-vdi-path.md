---
layout: post
title: "window7 修改docker安装的machine 位置"
description: ""
date: "2017-05-26 00:00:01"
categories:
  - develop
tags:
  - docker
  - virtual
---
从前blog移植过来，暂无摘要，后期再补
<!-- more -->  



win7下安装Docker ，默认的machine location 是在C:\users\xx\.docker\machine\machines 下面，为了不占用系统盘，想修改盘符位置


google了一下，发现只需要设置MACHINE_STORAGE_PATH环境变量就可以，变量值为你想要设置的路径保存，重新运行docker quickstart


流程如下

1. 设置MACHINE_STORAGE_PATH环境变量

2. 运行Docker Quickstart Termina

如果想转移现有的可以试试下面的方法

1. 关闭停止Docker的虚拟机。

2. 打开VirtualBox，选择“管理”菜单下的“虚拟介质管理”，

3. 选中docker创建的“disk”，然后点击菜单中的“复制”命令，根据向导，把当前的disk复制到另一个盘上面去。

4. 回到VirtualBox主界面，右键“default”这个虚拟机，选择“设置”命令，在弹出的窗口中选择“存储”选项。

5. 把disk从“控制器SATA”中删除，然后重新添加我们刚才复制到另外一个磁盘上的那个文件。


引用
http://blog.csdn.net/u011248395/article/details/70994088