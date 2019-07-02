---
title: 在flutter里踩过的坑
comments: true
share: true
toc: true
categories:
  - develop
tags:
  - develop
  - flutter
  - language

date: 2019-05-15 08:22:06
---

电脑没电了，先写个摘要
<!-- more -->  
# flutter

好用

但没怎么用

好坑

# 坑s

先记一下有哪些坑

## 开发模式下和发布模式下，获取宽度的时机不一样

```bash
flutter run

flutter run --profile

flutter run --release

```

## 在有provide builder 的情况，有时会重新build

再写。。。