---
title: "几款LINUX下的CHM查看器"
comments: true
share: true
toc: true
date: "2015-11-28 00:00:01"
categories:
  - tools

tags:
  - reader
  - chm

---



从前blog移植过来，暂无摘要，后期再补

<!--more-->

  

本文旨在介绍linux下的常见chm阅读软件及其安装，并针对一些问题给出解决方法。

### 一、CHMSEE 

这个比较常见了，呵呵。

安装: 

    sudo apt-get install chmsee
    
之后在应用程序附件中就可以看到了。

####问题1：

启动不了或者出现

chmsee: error while loading shared libraries: libxul.so: cannot open shared object file: No such file or directory

的错误就作如下处理：
    
    cd /usr/lib 
    sudo ln -s xulrunner-1.9/libxul.so libxul.so 
    sudo ln -s xulrunner-1.9/libxpcom.so libxpcom.so 
    sudo ln -s xulrunner-1.9/libsqlite3.so libsqlite3.so 
    sudo ln -s xulrunner-1.9/libmozjs.so libmozjs.so
    
之后可以正常打开了。


### 二、Kchmiewer 

这个是kde下出色一个chm阅读器，相比较于chmsee出现中文乱马的情况而言，这个可以说是完美了。
安装：

    sudo apt-get install kchmviewer

在ubuntu8.04下，依然在应用程序，附件中出现。

###三、xchm 

安装：

    sudo apt-get install xchm

### 四、chmview 

它是个非常强大的chm阅读器。不过其原理略微有点复杂。我们知道chm实际上是被编译过的html，对了，chmview就是建立了一个简单的http服务器，借助于浏览器来阅读chm，这个就是其基本服务原理。不过有时候也会有点莫名其妙的错误。

### 五、GNOCHM 

这是一个比较完美的chm阅读器了，可以说是完美支持中文的。

    sudo apt-get install gnochm

### 六、okular

    sudo apt-get install gnochm
    sudo apt-get install okular-extra-backends 
    
### 七、fbreader

    sudo apt-get install fbreader
    



> 引用地址：http://blog.csdn.net/aking21alinjuju/article/details/4436440