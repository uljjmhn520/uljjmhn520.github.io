---
title: "debian 安装fcitx五笔拼音"
comments: true
share: true
toc: true
date: "2015-02-20 00:00:01"
categories:
  - other

tags:
  -  debian 
  -  fcitx 
  -  wubi

---




从前blog移植过来，暂无摘要，后期再补

<!--more-->

  

#### 更新本地软件包索引，并安装fcitx输入法框架以及fcitx五笔拼音输入法

    sudo apt-get update
    
    sudo apt-get install fcitx fcitx-table-wbpy fcitx-config-gtk


#### 配置fcitx五笔拼音输入法

  

上面的 apt-get install命令完成后，重新登录系统，这样是为了检测新安装的输入法。然后以普通用户在终端里输入下面的命令打开fcitx输入法配置窗口。


    fcitx-config-gtk3

在安装fcitx五笔拼音的同时也会安装拼音和双拼输入法，所以如果你只想要五笔拼音，那么可以在这个配置窗口里将拼音和双拼删除，保留键盘布局和五笔拼音输入法

将拼音和双拼删除后，你就可以用Ctrl+空格键来调出fcitx五笔拼音输入法了。既可以打五笔，又可以打拼音。打拼音的同时还会教你五笔怎么打，非常方便。


#### Telegram不能使用fcitx输入中文的解决办法

解决的方法很简单。打开home目录下的.bashrc文件。

    vim ~/.bashrc

将下面的三行命令添加到文件末尾。bashrc文件里的命令会在每次用户登录的时候执行。

    export GTK_IM_MODULE=fcitx
    export XMODIFIERS=@im=fcitx
    export QT_IM_MODULE=fcitx

保存文件后重新登录系统。现在就可以在telegram里用fcitx输入中文了。




