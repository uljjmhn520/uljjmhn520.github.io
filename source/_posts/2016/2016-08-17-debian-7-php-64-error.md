---
title: "debian 7 64位编译php5 的注意点"
comments: true
share: true
toc: true
date: "2016-08-17 00:00:01"
categories:
  - develop

tags:
  - php

---



从前blog移植过来，暂无摘要，后期再补

<!--more-->

  


debian 7 64位服务器由于lib路径的特殊性，编译php的时候，会一直抱某些lib文件找不到

比如libjpeg，libpng，libmysql等

其实我们只要用php的一个编译参数就可以解决这个问题，这个参数就是 –with-libdir=


    ./configure --prefix=/usr/local/php5 --with-iconv --with-zlib --enable-xml --with-gettext --with-curl --enable-force-cgi-redirect --enable-mbstring --with-mcrypt --with-gd --enable-gd-native-ttf --with-mhash --enable-sockets --with-xmlrpc --enable-zip --with-mysql --with-mysqli --with-pdo-mysql --enable-ftp --with-jpeg-dir --with-freetype-dir --with-png-dir --enable-bcmath --enable-calendar --enable-exif -with-openssl --with-bz2 --with-apxs2=/usr/local/apache2/bin/apxs --with-libdir=lib/x86_64-linux-gnu


注意 --with-libdir=lib/x86_64-linux-gnu


代表实际路径是 /usr/lib/x86_64-linux-gnu