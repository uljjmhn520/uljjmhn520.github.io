---
title: "PHP处理JSON字符串key缺少双引号的解决方法"
comments: true
share: true
toc: true
date: "2015-09-28 00:00:01"
categories:
  - web

tags:
  - json
  - php

---



从前blog移植过来，暂无摘要，后期再补

<!--more-->

  

这篇文章主要介绍了PHP处理JSON字符串key缺少双引号的解决方法,是非常常见的一类错误处理情况,需要的朋友可以参考下

本文实例讲述了PHP处理JSON字符串key缺少引号的解决方法，分享给大家供大家参考之用。具体方法如下：

通常来说，JSON字符串是key:value形式的字符串，正常key是由双引号括起来的。

例如：

    <?php
    $data = array('name'=>'fdipzone');
    echo json_encode($data);            // {"name":"fdipzone"}
    print_r(json_decode(json_encode($data), true)); //Array ( [name] => fdipzone )
    但如果json字符串的key缺少双引括起来，则json_decode会失败。
    
    <?php
    $str = '{"name":"fdipzone"}';
    var_dump(json_decode($str, true)); // array(1) { ["name"]=> string(8) "fdipzone" }
     
    $str1 = '{name:"fdipzone"}';
    var_dump(json_decode($str1, true)); // NULL
    ?>
    
解决方法：判断是否存在缺少双引括起来的key，如缺少则先用正则替换为"key"，再进行json_decode操作。

    <?php
    /** 兼容key没有双引括起来的JSON字符串解析
    * @param String $str JSON字符串
    * @param boolean $mod true:Array,false:Object
    * @return Array/Object
    */
    function ext_json_decode($str, $mode=false){
      if(preg_match('/\w:/', $str)){
        $str = preg_replace('/(\w+):/is', '"$1":', $str);
      }
      return json_decode($str, $mode);
    }
     
    $str = '{"name":"fdipzone"}';
    var_dump(ext_json_decode($str, true)); // array(1) { ["name"]=> string(8) "fdipzone" }
     
    $str1 = '{name:"fdipzone"}';
    var_dump(ext_json_decode($str1, true)); // array(1) { ["name"]=> string(8) "fdipzone" }
    ?>
    
希望本文所述对大家PHP程序设计的学习有所帮助。

> 引用地址：http://www.jb51.net/article/55208.htm