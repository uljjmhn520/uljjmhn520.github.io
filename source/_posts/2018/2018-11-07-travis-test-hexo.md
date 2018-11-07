---
title: 以编译hexo的方式试用travis
comments: true
share: true
toc: true
date: 2018-11-07 15:14:22
categories:
  - develop
tags:
  - travis
  - hexo
  - learn
---

试用一下持续集成服务 travis。
travis对github的开源仓库免费，正巧想写点啥子，正好笔者才换了hexo的blog，正好hexo源码和编译后的html文件在不同的仓库（分支）。

既然这么多的正巧那就把使用travis的过程记录下来吧

<!--more-->

# 参考连接

1. [使用Travis CI持续部署Hexo博客](https://www.jianshu.com/p/5691815b81b6)

# 默认流程


1. 使用 hexo g 命令生成静态html文件。生成的文件在 **public** 目录下：

    ```bash
    hexo g
    ```

2. 然后把 **public** 文件夹下所有文件push到github的某仓库或者本仓库的另一个分支

    ```bash
    cd public
    git init
    git config user.name "xx"
    git config user.email "xx@xx.xx"
    git add .
    git commit -m "update posts"
    git push --force --quiet "github url"
    ```

3. 前面两步可以可以用一个hexo命令完成 **hexo d**

    ```bash
    hexo d
    ```
    不过，在执行命令之前，要先配置 **_config.yml** 的 **deploy** 节点
    
    ```yaml
    deploy:
      type: git
      repo: github url
      branch: master
      message: update post
    ```

# 遇到的问题

1. 每次写完blog，除了要push到源码库，还要push到gitpage所在库。当然这个写一个bash脚本解决

2. 部署在同一个仓库的不同分支下，有时deploy会出错

3. 对于我这种有时在windows下用vagrant开发时，push到两个仓库不太友好
    1. git的ssh-key 在windows主机下，平时推拉代码都在主机完成
    2. 我windows下没装node环境，也不想装。运行环境都在虚拟机里
    3. 也就是说主机不能运行hexo，虚拟机不能git，这tmd就尴尬了
    4. 其它还没想到的问题
    
# 用 Travis 持续部署

## 思路

将Hexo源码和发布代码放到一个仓库的不同分支，便于一一对应，也是对博客源码的备份。

1. **master** 分支： 用于编译后的文件，也就是用于展示的html源码
2. **hexo-source** 分支： 存markdown源码

我使用Github Pages来展示自己的博客，并指定自定义域名。

使用Travis的配置，当仓库push后自动部署，不用手动发布。

## 流程

### hexo安装

自行百度 hexo 安装，这里不做
{% post_link markdown-learning-by-maxiang 点击这里查看这篇文章 %}


### 配置github
1. 新增一个Access Token，[https://github.com/settings/tokens]()
    如果链接变了，就去github的setting中找
2. 点击 **Generate new token**
3. Token description 描述，填自己能分辨的就行了
3. Select scopes，把repo 节点全部勾选就行了
5. 点击 Generate token 即生成成功，然后记下来，等会填到 Travis中去

### 配置travis

其实配置很简单，我们在官网使用github账号授权登录，hexo添加配置文件就可以了。

1. 登录[官网](https://www.travis-ci.org/)，使用github账号登录。
2. 同步github的仓库
3. 选中博客仓库
4. 设置travis的各项参数
    1. General，钩选 Build pushed branches
    2. Environment Variables，设置环境变量，该变量可以在 **.travis.yml** 中使用
        
        我们这里只把github的刚刚生成的token写入环境变量，这里不晓得会不会有安全问题，但是绝对不对写到 **.travis.yml** 里面
        
        name 填 GITHUB_TOKEN
        value 填 刚刚生成的token
        Display value in build log 别打钩，相对安全一点
5. 在源码中新建一个 **.travis.yml** 文件
    
    ```yaml
    language: node_js
    node_js: stable
    
    # S: Build Lifecycle
    install:
      - npm install
    
    script:
      - hexo clean
      - hexo g
    
    after_script:
      - cd ./public
      - git init
      - git config user.name ${GIT_CONFIG_USERNAME}
      - git config user.email ${GIT_CONFIG_EMAIL}
      - git add .
      - git commit -m "Update docs"
      - git push --force --quiet "https://${GITHUB_TOKEN}@${GH_REF}" master:master
    
    branches:
      only:
        - hexo-source
    
    #####################################
    # 环境变量，把相应的键值改为你自己的就行了 #
    #####################################
    env:
     global:
       - GIT_CONFIG_USERNAME: TonyJavaZ
       - GIT_CONFIG_EMAIL: uljjmhn520@gmail.com
       - GH_REF: github.com/uljjmhn520/uljjmhn520.github.io.git
    
    ```
    
6. 配置完成

    1. push 你的blog源码项目到github

    2. 去 travis 后台查看日志可以看到部署过程
    
# Re参考连接

1. [使用Travis CI持续部署Hexo博客](https://www.jianshu.com/p/5691815b81b6)