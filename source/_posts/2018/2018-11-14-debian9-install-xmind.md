---
title: debian9安装xmind8
comments: true
share: true
toc: true
categories:
  - linux
tags:
  - linux
  - debian
date: 2018-11-14 20:06:27
---

安装xmind
<!-- more -->  

# 下载

[进入官网](https://www.xmind.net/)下载[linux版](http://dl2.xmind.cn/xmind-8-update8-linux.zip)

# 解压

进入自己的喜欢的文件夹 **/path/to**，然后解压
```bash
unzip xmind-8-update8-linux.zip -d xmind8
```

# 安装

```bash
cd /path/to/xmind8

sudo ./setup.sh

```

# 运行

```bash
# 进入二进制文件目录
cd XMind_amd64/

# 运行
./XMind

```

> 后面还附了一个启动脚本


# 艰辛的运行过程

## 问题

### 无法在模块路径中找到主题引擎adwaita

```bash
sudo apt-get install gnome-themes-standard
```

### 不能运行，直接报错

按一般情况下，运行一个软件无论你当前在哪里都无所谓

当前我在软件的根目录 **/path/to/xmind8** 于是我就在当前文件夹直接执行了以下命令

```bash
XMind_amd64/XMind
```
于是报错了，查看日志 **configuration** 文件夹中的日志有以下报错信息

```text
!SESSION 2018-11-14 19:46:02.233 -----------------------------------------------
eclipse.buildId=R3.7.8.201807240049
java.version=1.8.0_181
java.vendor=Oracle Corporation
BootLoader constants: OS=linux, ARCH=x86_64, WS=gtk, NL=zh_CN
Framework arguments:  -eclipse.keyring @user.home/.xmind/secure_storage_linux
Command-line arguments:  -os linux -ws gtk -arch x86_64 -data ../workspace -eclipse.keyring @user.home/.xmind/secure_storage_linux

!ENTRY org.eclipse.osgi 4 0 2018-11-14 19:46:02.553
!MESSAGE Application error
!STACK 1
java.lang.IllegalStateException: Unable to acquire application service. Ensure that the org.eclipse.core.runtime bundle is resolved and started (see config.ini).
	at org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.start(EclipseAppLauncher.java:78)
	at org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:388)
	at org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:243)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.eclipse.equinox.launcher.Main.invokeFramework(Main.java:673)
	at org.eclipse.equinox.launcher.Main.basicRun(Main.java:610)
	at org.eclipse.equinox.launcher.Main.run(Main.java:1519)
	at org.eclipse.equinox.launcher.Main.main(Main.java:1492)
```

### 瞎扯

于是又google了半天没找到答案

然后一个不小心，点进了 **XMind_amd64** 文件夹

然后，wqnmlgb的。。。。

## 解决

```bash
cd /path/to/xmind8/XMind_amd64
./XMind
```

# 写个运行脚本

进入二进制文件夹

```bash
cd /path/to/xmind8/XMind_amd64
```

建一个脚本，命名为 **run.sh** ，脚本内容为：

```bash
#!/bin/bash
# 获取脚本所在目录
SHELL_FOLDER=$(dirname $(readlink -f "$0"))

cd $SHELL_FOLDER
./XMind
```


直接复制下列命令在命令行中键入即可，当然也可以自建一个文件夹然后修改里面的内容

```bash

cat <<EOF > run.sh
#!/bin/bash
# 获取脚本所在目录
SHELL_FOLDER=\$(dirname \$(readlink -f "\$0"))

cd \$SHELL_FOLDER
./XMind
EOF


```

别忘了给执行权限

```bash
chmod +x run.sh
```

然后就可以在任何地方执行 **run.sh** 了

```bash
/path/to/run.sh

# or

sh /path/to/run.sh

```