---
title: "deban安装composer"
comments: true
share: true
toc: true
date: "2015-07-22 00:00:01"
categories:
  - web

tags:
  - php
  - debian
  - composer

---



从前blog移植过来，暂无摘要，后期再补

<!--more-->

  


## 常用方式

1. -

        cd /usr/local/bin

2. -

        curl -sS https://getcomposer.org/installer | php

3. 完成后，当前文件夹就会多出一个 composer.phar ，重命名为 composer 

        mv composer.phar composer

4. -

        chmod a+x composer

5. -

        composer self-update
    
6. 安装一些常用的全局的工具

        #phpunit
        composer global require 'phpunit/phpunit'
        
        
        #php-cs-fixer
        #composer global require 'fabpot/php-cs-fixer:dev-master'   
        
        #上面那个是老版本，改成下面那个了
        composer global require 'friendsofphp/php-cs-fixer:dev-master'


## 优雅方式

本方式引用自 http://blog.csdn.net/meegomeego/article/details/38984051

1. 随便一个文件夹下载composer.phar , 比如 ~/

        cd ~ && curl -sS https://getcomposer.org/installer | php

2. 安装各类 global 工具，包括composer自己也是可以用composer来安装的
 
        ./composer.phar global require 'composer/composer:dev-master'
        
        ./composer.phar global require 'phpunit/phpunit:3.7.*'
        
        ./composer.phar global require 'fabpot/php-cs-fixer:dev-master'

3. 将 vendor/bin 添加到你的PATH变量里

    * 本方式引用至 http://blog.csdn.net/meegomeego/article/details/38984051
    * 原文中bin目录为 ~/.composer/vendor/bin
    * 本人的bin目录为 ~/.config/composer/vendor/bin
    * 可能是系统不同的原因（本人用的debian jessie）或者是composer版本等原因

4. self-update 方法

    貌似没有找到。哈哈哈哈