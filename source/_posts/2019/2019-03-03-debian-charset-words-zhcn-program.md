---
title: debian系统下各种中文显示、乱码、输入等问题
comments: true
share: true
toc: true
categories:
  - linux
tags:
  - linux
  - debian
  - charset
  - input
  - language
date: 2019-03-03 11:04:25
---

记录debian下面各种中文字符的问题

<!-- more -->  

> 未完待续。

> 以前遇到的时候解决了，然后后面又遇到又要一直去搜。现在开始，遇到了就记录一下，以后直接就翻这里就完了。

# 系统

## 输入法

# docker

## mysql


# 游戏

## dota2

dota2中fcitx输入中文

```bash
# 我用的fcitx输入法，其它的可以试试，在下没试过
export SDL_IM_MODULE=fcitx
```

这一步能解决dota2中几个聊天界面的中文输入，但还有些地方不能输入中文，比如steam 的im (区别steam和dota2，进入dota2前的好友与聊天，以前在游戏中按 shift+tab 键)

steam 的im 暂没找到方法，以下可以参考，但我试了不行

https://www.ubuntukylin.com/ukylin/forum.php?mod=viewthread&tid=9433

