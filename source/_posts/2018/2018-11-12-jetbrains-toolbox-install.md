---
title: 'jetbrains toolbox的安装'
comments: true
share: true
toc: true
categories:
  - develop
tags:
  - jetbrains
date: 2018-11-12 11:13:47
---

使用jetbrains的ide多年了，已经习惯了他家的操作习惯。日常使用包括phpstorm、datagrip、intellij idea。jetbrains toolbox的安装是很简单的，只是有时会出一些没见过的错，现把这些记录下来。
<!-- more -->  


# 安装

去官网看看就行，本文略过。。。。。。

# 遇到的问题

##  Qt WebEngine报错
- 系统
  才安装好的 debain stretch，纯净无污染
- 出现原因
  原因未明，用debian8的时候从来没有出现过，现在换了debian9，就出了这个错
- 报错信息（debain系统）
  ```bash
  WARNING:resource_bundle_qt.cpp(114)] locale_file_path.empty() for locale
  Qt WebEngine ICU data not found at /home/hadege/dm/dm-Fotowelt/resources_qt/resources. Trying parent directory...
  Installed Qt WebEngine locales directory not found at location /home/hadege/dm/dm-Fotowelt/translations/qtwebengine_locales. Trying application directory...
  Qt WebEngine locales directory not found at location /home/hadege/dm/dm-Fotowelt/qtwebengine_locales. Trying fallback directory... Translations MAY NOT not be correct.
  Qt WebEngine resources not found at /home/hadege/dm/dm-Fotowelt/resources_qt/resources. Trying parent directory...
  ```

- 解决
  ```bash
  apt-get install libqt5webenginecore5

  # 重启计算机
  reboot
  ```