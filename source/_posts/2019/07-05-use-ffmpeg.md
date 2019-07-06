---
title: use-ffmpeg
comments: true
share: true
toc: true
categories:
  - other
tags:
  - other
date: 2019-07-05 13:12:47
---

abstract of this post
<!-- more -->  
content of this post


# 安装

[官网](https://wiki.debian.org/ffmpeg#Installation)

```bash

apt-get install libav-tools 

apt-get install ffmpeg
```


# 使用

## 下载m3u8

```bash

ffmpeg -i "http://host/folder/file.m3u8" -bsf:a aac_adtstoasc -vcodec copy -c copy -crf 50 file.mp4
```
