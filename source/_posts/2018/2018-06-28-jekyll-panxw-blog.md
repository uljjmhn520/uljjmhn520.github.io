---
title: "jekyll panxw blog"
comments: true
share: true
toc: true
date: "2018-06-28 18:07:32"
categories:
  - other

tags:
  - 

---



从前blog移植过来，暂无摘要，后期再补
<!-- more -->  


准备把blog 改成这个 panxw 的模板，现在写一下改的过程 
<!--more-->

  

## 官方blog

https://www.panxw.com/

## 源码地址

https://github.com/panxw/panxw.github.com

# 用法

参见官网


# 改动

下面说一下我使用中的改动

## 修改配置文件

### 修改 _config.yml

    #permalink节点 #我的习惯年月 日就算了，毕竟一天不可能一天几篇
    permalink: /:categories/:year/:month/:title
    
    # 然后这几个 人个配置信息
    github: uljjmhn520
    author: "lopy"
    email: xxxx#163.com
    name: "lopy's Blog"
    baseurl: /
    url: http://blog.lopy.win
    domain: blog.lopy.win
    
    # 分类，暂时不管，以后按自己的情况修改
    all_categories: [
      ["android", "Android开发","/android/index.html"], 
      ["react", "React Native", "/react/index.html"],
      ["web", "Web建站","/web/index.html"], 
      ["linux", "Linux相关","/linux/index.html"],
      ["git", "git用法","/git/index.html"],
      ["program", "软件开发","/program/index.html"],
      ["vps", "VPS","/vps/index.html"],
      ["other", "杂记","/other/index.html"],
      ["read", "书摘","/read/index.html"], 
      ["about", "关于","/about.html"]
    ]
    
    # 加入节点 friendly_links ，将友链写入配置文件
    friendly_links: [
      ["GitHub","https://github.com"],
      ["baidu","https://www.baidu.com"],
    ]

    

## 修改部分源码

### 加入 Rakefile 

这个提取自 jekyll-bootstrap 然后稍微改了几句和post 相关的，其他的没有改完。

### 改 index.html

    <span class="glyphicon glyphicon-time"></span>
        { { post.date | date:"%F %T" }}
    </div>
    


### 改 _layouts/post.html

    日期：{ { page.date | date:"%F %T" }}&nbsp;&nbsp;&nbsp;
    
### 修改友链页面

    ## 改成从配置文件中获取  friendlinks.html
    
    <ul class="list-unstyled">
        { % for link in site.friendly_links %}
        <li>
            <a href="{ {link[1]}}" target="_blank" rel="nofollow">
                { {link[0]}}
            </a>
        </li>
        { % endfor %}
    </ul>
    
### 新增友链按钮

    <div class="linkme">
        <a href="http://mail.qq.com/cgi-bin/qm_share?t=qm_mailme&email=w7SqraWqsa6DsrLtoKyu" target="_blank">
            <span class="linkme_span">交换链接 暂不改1</span>
        </a>
    </div>