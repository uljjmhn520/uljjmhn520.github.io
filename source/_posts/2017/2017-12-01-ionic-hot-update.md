---
layout: post
title: "ionic hot update"
description: ""
category : "@web"
date: "2017-12-01 00:00:01"
tags: []
---
从前blog移植过来，暂无摘要，后期再补
<!-- more -->  


## ionic3 热更新学习

### 1.安装基本框架

    npm install -g ionic@latest
    npm install -g cordova ionic
    

### 2.新建ionic项目

    ionic start myapp
    
### 3.进入项目文件夹

    # 执行下面命令可以预览项目
    cd myapp
    
    # 正常显示后可以关掉服务Ctrl+C，此步骤只是保证ionic新建项目成功
    ionic serve

### 4.ios目前已不支持热更新，所以只对Android平台进行设置

    # 设置Android平台
    ionic cordova platform add android
    
    # 设置安卓版本需修改下面两个文件内容的target的值，默认设好了
    platforms/android/project.properties 
    platforms/android/CordovaLib/project.properties 
    
    # 安装热更新插件
    cordova plugin add cordova-hot-code-push-plugin
    cordova plugin add cordova-hot-code-push-local-dev-addon
    npm install -g cordova-hot-code-push-cli
    
### 5.在config.xml配置文件中加入下面节点

    <chcp>
         <config-file url="http://192.168.1.203:8121/chcp.json" />
         <native-interface version="1" />
    </chcp>
    # 第一个子节点是需要发布在iis上的文件地址
    # 第二个子节点是当前版本号
    # 还有其它配置此处不再罗列
    
### 6.新开一个终端执行下面命令

    cordova-hcp server
    如果能够正常输出类似
    Running server
    Checking:  /ionic/myapp/www/
    local_url http://localhost:31284
    Warning: .chcpignore does not exist.
    Build 2017.10.27-10.17.48 created in ionic/myapp/www
    cordova-hcp local server available at: http://localhost:31284
    cordova-hcp public server available at: https://5027caf9.ngrok.com
    
    检查/项目名称/www 路径下 有chcp.json和chcp.manifest表示热更新服务启动正常