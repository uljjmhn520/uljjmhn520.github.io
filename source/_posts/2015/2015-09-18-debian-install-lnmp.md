---
title: "Debian apt-get 一键安装配置搭建最新LNMP"
comments: true
share: true
toc: true
date: "2015-09-18 00:00:01"
categories:
  - develop

tags:
  - debian
  - php

---



我的常用开发环境为debian，偶尔重装系统会重新安装php环境

<!--more-->

# 更新源

## debian7 only
> debian7 已经好久没有用了，印象中是不带php的，所以需要单独做以下步骤

> debian7 以下没有用过，就没有相应的了

导入dotdeb源：

打开 /etc/apt/sources.list,向其中添加如下四行：
```bash
deb http://packages.dotdeb.org wheezy all 
deb-src http://packages.dotdeb.org wheezy all
deb http://packages.dotdeb.org wheezy-php56 all
deb-src http://packages.dotdeb.org wheezy-php56 all
```

打开命令行，下载并导入GnuPG key：
```bash
wget http://www.dotdeb.org/dotdeb.gpg
cat dotdeb.gpg | apt-key add -
    ```

## debian 8 或 9
用默认的源或用该篇文章的源

# 更新本地
```bash
apt-get update
```
# 安装

## debian7 或 8
> debian7 dotdeb的php源的版本为5.6

> debian8的php源的版本为5.6

打开命令行：
```bash
apt-get install nginx mysql-server php5-fpm php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-common php5-mysql php5-pspell php5-recode php5-dev php5-sqlite php5-tidy php5-xmlrpc php5-xsl php5-memcached memcached
```

或分行式的
```bash
apt-get install nginx mysql-server php5-fpm php5-curl php5-gd \ 
php5-intl php-pear php5-imagick php5-imap php5-mcrypt \
php5-common php5-mysql php5-pspell php5-recode php5-dev \
php5-sqlite php5-tidy php5-xmlrpc php5-xsl php5-memcached \
memcached
```

## debian9
> debian9的php源的版本为7.0

打开命令行：
```bash
apt-get install nginx mysql-server php7.0-fpm php7.0-curl php7.0-gd php7.0-intl php-pear php7.0-imagick php7.0-imap php7.0-mcrypt php7.0-common php7.0-mysql php7.0-pspell php7.0-recode php7.0-dev php7.0-sqlite php7.0-tidy php7.0-xmlrpc php7.0-xsl php7.0-memcached memcached
```

或分行式的
```bash
apt-get install nginx mysql-server php7.0-fpm php7.0-curl \
php7.0-gd php7.0-intl php-pear php7.0-imagick php7.0-imap \
php7.0-mcrypt php7.0-common php7.0-mysql php7.0-pspell \
php7.0-recode php7.0-dev php7.0-sqlite php7.0-tidy \
php7.0-xmlrpc php7.0-xsl php7.0-memcached memcached
```
## 配置环境
> 以下就不理更新了，年代久远

执行下面命令：

```bash
vi /etc/nginx/sites-available/default
```
    
按照下面来修改：
```bash
location ~ \.php$ {
    fastcgi_split_path_info ^(.+\.php)(/.+)$;
    # # NOTE: You should have "cgi.fix_pathinfo = 0;" in php.ini
    ## # With php5-cgi alone:
    # fastcgi_pass 127.0.0.1:9000;
    # # With php5-fpm:
    fastcgi_pass unix:/var/run/php5-fpm.sock;
    fastcgi_index index.php;include fastcgi_params;
}
```

修改保存之后重启Nginx：
```bash
service nginx restart
```
    
接下来我们下载一个探针，查看php的详细信息：

```bash
cd /usr/share/nginx/html/
wget http://www.yahei.net/tz/tz.zip
unzip tz.zip
```
    
保存之后访问网站网址 , 如果出现雅黑探针页面，则大功告成。

## 新建站点

和一般的lnmp一键包不同，采用这个方法所安装的 LNMP 需要手动添加站点配置文件。

进入配置文件目录，新建一个站点配置文件，比如 
```bash
vi abcd.com.conf。
cd /etc/nginx/conf.d
```
    
按照下面添加配置文件：
```bash
server {
    listen 80;
    #ipv6#listen [::]:80 default_server;
    root /usr/share/nginx/html/abcd.com;
    #默认首页文件名
    index index.php index.html index.htm;
    #绑定域名
    server_name abcd.com;
    #伪静态规则
    include wordpress.conf;
    location \ {
        try_files $uri $uri/ /index.html;
    }
    #定义错误页面
    #error_page 404 /404.html;
    location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass 127.0.0.1:9000;
        fastcgi_index index.php;
        include fastcgi_params;
    }
    #PHP
}
```

保存之后重启Nginx，添加及绑定网站即完成。

最后，附上WordPress的Nginx伪静态规则：
```bash
location / {
    if (-f $request_filename/index.html){
        rewrite (.*) $1/index.html break;
    }
    if (-f $request_filename/index.php){
        rewrite (.*) $1/index.php;
    }
    if (!-f $request_filename){
        rewrite (.*) /index.php;
    }
}
```

# 其它

## 错误

1、步骤2的问题，以前写的，忘了什么情况了