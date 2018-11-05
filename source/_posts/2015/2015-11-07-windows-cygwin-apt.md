---
title: "Windows下安装Cygwin及包管理器apt-cyg"
comments: true
share: true
toc: true
date: "2015-11-07 00:00:01"
categories:
  - tools

tags:
  - 

---



从前blog移植过来，暂无摘要，后期再补

<!--more-->

  

依赖

    wget tar gawk bzip2

执行

    wget http://apt-cyg.googlecode.com/svn/trunk/apt-cyg -P /bin chmod.exe +x /bin/apt-cyg
    
更换镜像

    apt-cyg -m http://mirrors.163.com/cygwin/

更新源

    apt-cyg update

安装

    apt-cyg install ping -u

-u表示每次不用更新源





如果每次安装都报错的话，参考

http://www.07net01.com/2015/08/891311.html

    -# install apt-cyg 
    lynx -source rawgit.com/transcode-open/apt-cyg/master/apt-cyg > apt-cyg 
    -#install 
    install apt-cyg /bin 
    -#link source 
    apt-cyg -m http://mirrors.163.com/cygwin/ 
    -#update 
    apt-cyg update 
    -#Example use of apt-cyg: 
    apt-cyg install nano
    
> 引用地址：http://my.oschina.net/looly/blog/214857