---
title: "Debian 7 apt-get一键安装配置搭建最新LNMP"
comments: true
share: true
toc: true
date: "2015-09-18 00:00:01"
categories:
  - web

tags:
  - debian
  - lnmp

---



从前blog移植过来，暂无摘要，后期再补

<!--more-->

  

1.我们首先要导入dotdeb源：

打开 /etc/apt/sources.list。

向其中添加如下四行：

    deb http://packages.dotdeb.org wheezy all 
    deb-src http://packages.dotdeb.org wheezy all
    deb http://packages.dotdeb.org wheezy-php56 all
    deb-src http://packages.dotdeb.org wheezy-php56 all

下载并导入GnuPG key：

    wget http://www.dotdeb.org/dotdeb.gpg
    cat dotdeb.gpg | apt-key add -
    
2.更新debian安装源：

    apt-get update

3.使用命令一键安装lnmp：

    apt-get install nginx mysql-server php5-fpm php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-common php5-mysql php5-pspell php5-recode php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl php5-memcached memcached
    
4.配置环境：

执行下面命令：

    vi /etc/nginx/sites-available/default
    
按照下面来修改：

    ......location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        # # NOTE: You should have "cgi.fix_pathinfo = 0;" in php.ini
        ## # With php5-cgi alone:
        # fastcgi_pass 127.0.0.1:9000;
        # # With php5-fpm:
        fastcgi_pass unix:/var/run/php5-fpm.sock;
        fastcgi_index index.php;include fastcgi_params;
    }.....

修改保存之后重启Nginx：

    service nginx restart
    
接下来我们下载一个探针，查看php的详细信息：

    cd /usr/share/nginx/html/
    wget http://www.yahei.net/tz/tz.zip
    unzip tz.zip
    
保存之后访问网站网址 , 如果出现雅黑探针页面，则大功告成。

5.如何新建站点：

和一般的lnmp一键包不同，采用这个方法所安装的 LNMP 需要手动添加站点配置文件。

进入配置文件目录，新建一个站点配置文件，比如 

    vi abcd.com.conf。
    cd /etc/nginx/conf.d
    
按照下面添加配置文件：

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

保存之后重启Nginx，添加及绑定网站即完成。

最后，附上WordPress的Nginx伪静态规则：

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




错误：1、步骤2的问题