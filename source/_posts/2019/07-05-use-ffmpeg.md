---
title: ffmpeg使用
comments: true
share: true
toc: true
categories:
  - develop
tags:
  - develop
  - debian
date: 2019-07-05 13:12:47
---

ffmpeg是一个非常强大的视频处理程序，以后还会用得更多，现在开始记录
<!-- more -->  

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
