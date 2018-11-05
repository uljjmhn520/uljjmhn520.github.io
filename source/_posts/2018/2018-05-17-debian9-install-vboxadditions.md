---
title: "vbox中debian9安装增强功能和文件共享"
comments: true
share: true
toc: true
date: "2018-05-17 00:00:01"
categories:
  - linux

tags:
  - debian
  - virtualbox

---



从前blog移植过来，暂无摘要，后期再补

<!--more-->

  

# 安装

## 先安装以下

    apt update
    
    apt upgrade
    
    apt install build-essential module-assistant dkms
    
    reboot


## 然后安装 VBoxAdditions

* 在vbox 进入debian系统

* 然后 Devices > Insert Guest Additions CD image.
![图](/assets/images/2018-05-17/debian-9-virtualbox-guest1.png)

* 然后，在系统中挂载VBoxAdditions光盘镜像


        mount /media/cdrom 
        
* 安装插件

        
        sh /media/cdrom/VBoxLinuxAdditions.run
        reboot
        
## 设置共享文件夹

* 设置》共享文件夹》 新建
* 选择路径，
* 设置名称，比如 vbox_sharing 
* 勾选 自动挂载和固定分配，点确定

后面补图

## 设置开机自动挂载到到指定点

前面设置好共享文件夹后，系统启动时，会挂载到 /media/sf_<挂载名称>，如 /media/sf_vbox_sharing

现在，我们要设置自动挂载到指定点，就是修改 /etc/fstab 

挂载命令的格式为，挂载之前 path 应该存在， &lt; &gt; 中间的值可变

&lt;sharing name&gt; &lt;path&gt; vboxsf &lt;options&gt; 0 0
如

    mkdir /var/vbox_sharing
    vbox_sharing /var/vbox_sharing vboxsf comment=systemd.automount 0 0

然后保存，重启，不出意外就成功了

其中，option 中可有很多参数

到时给个链接，现在没时间去找

其中 comment=systemd.automount 参数没有，貌似就不会成功

还有其它的，比如指定用户组

gid=1000,uid=1000

如:

    vbox_sharing /var/vbox_sharing vboxsf gid=1000,uid=1000,comment=systemd.automount 0 0


# 引用

https://www.linuxbabe.com/debian/install-virtualbox-guest-additions-debian-9-stretch

https://askubuntu.com/questions/365346/virtualbox-shared-folder-mount-from-fstab-fails-works-once-bootup-is-complete