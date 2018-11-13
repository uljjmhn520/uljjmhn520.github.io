---
title: "PHP自动捕捉页面500错误示例"
comments: true
share: true
toc: true
date: "2016-08-19 00:00:01"
categories:
  - develop

tags:
  -  php 
  -  error 

---



从前blog移植过来，暂无摘要，后期再补

<!--more-->

  

### 一、解决方法

　　通常程序发生致命错误的时候页面空白，想获取错误信息也不难!主要是利用两个函数：

1、error_get_last() 获取最后一次发生错误信息，结构如下：

    Array
    (
        [type] => 8
        [message] => Undefined variable: http://www.111cn.net
        [file] => C:WWWindex.php
        [line] => 2
    )

2、register_shutdown_function() 在脚本停止执行时注册一个回调函数

有了这两个函数就可以监控致命错误了：

    error_reporting(E_ALL); //E_ALL

    function cache_shutdown_error() {

        $_error = error_get_last();

        if ($_error && in_array($_error['type'], array(1, 4, 16, 64, 256, 4096, E_ALL))) {

            echo '<font color=red>你的代码出错了：</font></br>';
            echo '致命错误:' . $_error['message'] . '</br>';
            echo '文件:' . $_error['file'] . '</br>';
            echo '在第' . $_error['line'] . '行</br>';
        }
    }

    register_shutdown_function("cache_shutdown_error");


### 二、附上本地服务器测试方法

　　下面来说说显示PHP错误提示消息的三个方法。

1、php.ini配置

php.ini 配置中与此相关的有两个配置变量。下面是这两个变量及其默认值

    display_errors = Off
    error_reporting = E_ALL & ~E_NOTICE

display_errors 变量的目的很明显 —— 它告诉PHP是否显示错误。默认值是 Off。现在我们的目的是显示错误提示，那么：

    display_errors = On

　　E_ALL，这个设置会显示从不良编码实践到无害提示到出错的所有信息。E_ALL 对于开发过程来说有点太细，因为它连变量未初始化也显示提示，而这一点正是PHP“高级”的一个特征。幸好，error_reporting的默认值是“E_ALL & ~E_NOTICE”，这样就只看到错误和不良编码了，对程序无不利的提示则不会显示。
　　

　　修改php.ini后需要重新启动Apache，这样才可以在apache中生效，当然你如果只在命令行下测试程序，是不需要这一步的。


　　配置php程序中

    <?php
        //禁用错误报告
        error_reporting(0);
        //报告运行时错误
        error_reporting(E_ERROR | E_WARNING | E_PARSE);
        //报告所有错误
        error_reporting(E_ALL);
    ?>

