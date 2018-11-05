---
title: "linux (debian) 启动报错 contains a file system with errors.check forced"
comments: true
share: true
toc: true
date: "2016-06-28 00:00:01"
categories:
  - linux

tags:
  - linux
  - error

---



从前blog移植过来，暂无摘要，后期再补

<!--more-->

  

### 今天开机，debian起动不了了。搜索了一下，应该硬盘的逻辑卷无法加载。

### 用 fsck 命令解决，特此记录


    fsck -C fd -N /dev/sda[n]     #命令中 [n] 为出错的分区，一般为 /boot 分区

结果为 [/sbinfsck.ext4 (1) -- /dev/sda[n] ] ......

然后执行命令

    fsck.ext4 -C0 /dev/sda[n]

期间会多次地提示输入 yes/y 直接输入y 就行了。

完成后，会提示FILE SYSTEM WAS MODIFIED

不出意外，重启系统后就能成功登录了
