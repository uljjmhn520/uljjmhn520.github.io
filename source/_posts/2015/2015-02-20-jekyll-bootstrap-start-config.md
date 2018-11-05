---
title: "jekyll bootstrap 的搭建"
comments: true
share: true
toc: true
date: "2015-02-20 00:00:02"
categories:
  - other

tags:
  -  jekyll
  -  config

---



从前blog移植过来，暂无摘要，后期再补

<!--more-->

  

#### 1、update ，你懂的

    sudo apt-get update

#### 2、安装 gem

    sudo apt-get install gem

#### 3、jekyll 依赖 ruby，so 安装之

    sudo apt-get install ruby-full build-essential 

#### 4、安装 jekyll 等各项工具

    gem install jekyll


#### 5、

    sudo gem install bundler

#### 6、

    sudo gem install jekyll-sitemap

#### 7、

    sudo gem install pygments.rb

#### 8、进入项目文件夹，启动服务

    cd USERNAME.github.com 
    jekyll serve

#### 9、一般项目根目录里面有 Gemfile 和 Gemfile.lock 文件，这是依赖，和composer类似

    # install gems required 直接运行 
    bundle install
    
#### 10、如果 jekyll serve 无法启动，则可以用bundle exec COMMAND 来执行，一般是依赖的版本不对引起的
    
    bundle exec jekyll serve
    

#### end



### 参考资料

>     https://www.rosehosting.com/blog/how-to-install-jekyll-on-debian-8/
>     https://github.com/jekyll/jekyll/issues/4972
>     http://stackoverflow.com/questions/19061774/cannot-load-such-file-bundler-setup-loaderror
>     http://jekyllbootstrap.com/usage/jekyll-quick-start.html