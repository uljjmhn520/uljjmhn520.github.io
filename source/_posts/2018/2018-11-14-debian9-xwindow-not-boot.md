---
title: debian9-xwindow-not-boot
comments: true
share: true
toc: true
categories:
  - linux
tags:
  - debian
  - linux
date: 2018-11-14 18:43:27
---

一个不小心把debian8升级到了debian9，然后悲剧就开始了

<!-- more -->  

# 瞎扯

## 起因

本来只是想安装一个软件，貌似是xmind。然后因为依赖的 opensdk 不能更新。查了一下，发觉可能是因为国内某源的原因，于是换国外的源。

## 悲剧开始

源的网址是从家里的debian9 拷过来了

拷的时候，忘了把 stretch 改成 jessie

然后怎个系统一起更新了

# 出现问题

## 开机不自动进入桌面

# 解决过程

## 进入桌面

### 方案一，启用显示管理器

在下用的是 sddm，其它的还有kdm等，本文以sddm为例 

用 **root** 登录后输入以下：
```bash
# 如果命令行运行正确，则会进入登录界面
systemctl start sddm
```

### 方案二，用普通用户登录
用普通用户登录后输入以下：
```bash
# 如果命令行运行正确，则会进入登录界面
startx
```

## 配置自启动

### 尝试

虽然本次进入了桌面，但重启后还是不会自动启动

于是换照常理

```bash
systemctl enable sddm
```

结果，报错了

```text
Synchronizing state of sddm.service with SysV service script with /lib/systemd/systemd-sysv-install.
Executing: /lib/systemd/systemd-sysv-install enable sddm
The unit files have no installation config (WantedBy, RequiredBy, Also, Alias
settings in the [Install] section, and DefaultInstance for template units).
This means they are not meant to be enabled using systemctl.
Possible reasons for having this kind of units are:
1) A unit may be statically enabled by being symlinked from another unit's
   .wants/ or .requires/ directory.
2) A unit's purpose may be to act as a helper for some other unit which has
   a requirement dependency on it.
3) A unit may be started when needed via activation (socket, path, timer,
   D-Bus, udev, scripted systemctl call, ...).
4) In case of template units, the unit is meant to be enabled with some
   instance name specified.
```

### 解决


其实不知道最后怎么解决的，我记得输过以下命令

1. test1
    ```bash
    sudo systemctl disable sddm
    sudo systemctl enable sddm
    ```

2. test2
    ```bash
    sudo dpkg-reconfigure sddm
    ```

3. test3
    ```bash
    sudo systemctl enable sddm -f
    ```

4. test4
    ```bash
    sudo apt-mark hold sddm
    ```


以上操作在以下链接中找到的

[https://forums.netrunner.com/showthread.php?tid=23477&page=6](https://forums.netrunner.com/showthread.php?tid=23477&page=6)