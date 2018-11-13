---
title: "[转]在命令行下运行PHP脚本[带参数]的方法"
comments: true
share: true
toc: true
date: "2015-09-27 00:00:01"
categories:
  - develop

tags:
  - php
  - cli

---



从前blog移植过来，暂无摘要，后期再补

<!--more-->

  


这里介绍的是在命令行执行php脚本的代码，其实主要用到的是php.exe,所以注意设置环境变量。


创建一个简单的文本文件，其中包含有以下PHP代码，并把它保存为hello.php： 


复制代码代码如下:

    <?php 
        echo "Hello from the CLI"; 
    ?>

现在，试着在命令行提示符下运行这个程序，方法是调用CLI可执行文件并提供脚本的文件名： 

    #php phphello.php 
    //输出Hello from the CLI 


使用标准的输入和输出 
你可以在自己的PHP脚本里使用这三个常量，以接受用户的输入，或者显示处理和计算的结果。要更好地理解这一点，可以看看下面的脚本（列表A）： 

列表A 

复制代码代码如下:

    <?php 
        // ask for input 
        fwrite(STDOUT, "Enter your name: "); 
        // get input 
        $name = trim(fgets(STDIN)); 
        // write input back 
        fwrite(STDOUT, "Hello, $name!"); 
    ?>

Look what happens when you run it: 

    shell> php hello.php 
    Enter your name: Joe 
    // Hello, Joe!
 

在这个脚本里，fwrite()函数首先会向标准的输出设备写一条消息，询问用户的姓名。然后它会把从标准输入设备获得的用户输入信息读 


取到一个PHP变量里，并它把合并成为一个字符串。然后就用fwrite()把这个字符串打印输出到标准的输出设备上。 


-----------------使用命令行自变量 

在命令行里输入程序参数来更改其运行方式是很常见的做法。你也可以对CLI程序这样做。PHP CLI带有两个特殊的变量，专门用来达到这个 


目的：一个是$argv变量，它通过命令行把传递给PHP脚本的参数保存为单独的数组元素；另一个是$argc变量，它用来保存$argv数组里元素的 个数。 


用PHP脚本编写一段读取$argv并处理它所含参数的代码是很简单的。试试列表B里的示例脚本，看看它是如何工作的： 


列表B 


复制代码代码如下:

    <?php 
        print_r($argv); 
    ?>

    Run this script by passing it some arbitrary values, and check the output: 
    
    shell> php phptest.php chocolate 276 "killer tie, dude!" 
    Array 
    ( 
        [0] => test.php 
        [1] => chocolate 
        [2] => 276 
        [3] => killer tie, dude! 
    )


正如你可以从输出的结果看到的，传递给test.php的值会自动地作为数组元素出现在$argv里。要注意的是，$argvis的第一个自变量总是 

脚本自己的名称。 


下面是一个更加复杂的例子（列表C）： 

列表C 


代码 


复制代码代码如下:

    <?php 
        // check for all required arguments 
        
        // first argument is always name of script! 
        
        if ($argc != 4) { 
        
            die("Usage: book.php <check-in-date> <num-nights> <room-type> "); 
            
        } 
        
        // remove first argument 
        
        array_shift($argv); 
        
        // get and use remaining arguments 
        
        $checkin = $argv[0]; 
        
        $nights = $argv[1]; 
        
        $type = $argv[2]; 
        
        echo "You have requested a $type room for $nights nights, checking in on $checkin. Thank you for your order! "; 
    ?>
 



下面是其用法的示例： 


    shell> php phpbook.php 21/05/2005 7 single 

    You have requested a single room for 7 nights, checking in on 21/05/2005. Thank you for your order!
 

在这里，脚本首先会检查$argc，以确保自变量的数量符合要求。它然后会从$argv里提取出每一个自变量，把它们打印输出到标准的输出


> 引用地址：http://www.jb51.net/article/21879.htm