---
title: "为 hexo-next 增加搜索功能"
comments: true
share: true
toc: true
date: 2018-10-30 18:58:13
categories:
  - learn
tags:
  - blog
  - hexo
---

为 hexo - next 增加搜索功能，方便快速定位

<!--more-->


# 源自链接

> https://segmentfault.com/a/1190000010881874

# 用自带的插件实现

## 安装 hexo-generator-search

```bash

npm install hexo-generator-search --save

```

## 安装 hexo-generator-searchdb

```bash
npm install hexo-generator-searchdb --save
```

## 启用搜索
修改hexo配置文件，在根目录下的_config.yml中增加如下配置：
```yaml
search:
  path: search.xml
  field: post
  format: html
  limit: 10000

```

## 配置next中的搜索入口

打开themes\next_config.yml，将local_search.enable 设为true

```yaml
# Local search
local_search:
  enable: true


```

## 运行测试一下

```bash
hexo s
```