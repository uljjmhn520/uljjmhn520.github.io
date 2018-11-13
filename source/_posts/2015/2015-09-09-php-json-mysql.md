---
title: "php中的json转码问题以及保存在mysql中出现的问题"
comments: true
share: true
toc: true
date: "2015-09-09 00:00:01"
categories:
  - develop

tags:
  - json
  - mysql
  - php

---



从前blog移植过来，暂无摘要，后期再补

<!--more-->

  

出现问题及解决方法

json_encode('中文');会生成 "\u4e2d\u6587"要转回来就用json_decode('"\u4e2d\u6587"')就行了，但这不算一个问题。

  当你需要将你的某项数据通过json_encode()再存入数据库的话，就会出问题。数据库中显示“"u4e2du6587"”，少了斜杠就转不回“中文”了。这种情况的就可以用以下方法解决

  a、用 addslashes()处理后再存入数据库

      $str = json_encode('中文');
      $str = addslashes($str);
      echo $str;
      //结果为{"str":"\u4e2d\u6587"}
      
  b、用 json_encode('中文',JSON_UNESCAPED_UNICODE)处理的中文后，不会转为"\xxxx\xxxx"这个格式，直接转为'"中文"'。本功能在php5.4以上才能使用

    $str = json_encode('中文',JSON_UNESCAPED_UNICODE);
    //结果为"中文"
    $str = json_encode(array('str'=>'中文'),JSON_UNESCAPED_UNICODE);
    echo $str;
    //结果为{"str":"中文"}
    
 c、对于5.4以下的版本，可以对json_encode()后的字符串用正则替换

    $str = '中文';
    $str = json_encode($str);
    $str = preg_replace("#\\\u([0-9a-f]{4})#ie", "iconv('UCS-2BE', 'UTF-8', pack('H4', '\\1'))", $name);
    //结果为"中文"
    $arr= array('str'=>'中文');
    $str = json_encode($arr);
    $str = preg_replace("#\\\u([0-9a-f]{4})#ie", "iconv('UCS-2BE', 'UTF-8', pack('H4', '\\1'))", $name);
    echo $str;
    //结果为{"str":"中文"}


有时为了兼容性，可以将b、c方法封装成类

以下为封装代码

    class JSON
    {
        /**
         * @brief json数据格式编码,支持中文原文转换
         * @param $param max 要编码转换的数据
         * @return String json数据格式
         */
        public static function encode($param)
        {
            if(version_compare(phpversion(),'5.4.0') >= 0)
            {
                return json_encode($param,JSON_UNESCAPED_UNICODE);
            }
            $result = json_encode($param);
            //对于中文的转换
            return preg_replace("#\\\u([0-9a-f]{4})#ie", "iconv('UCS-2BE', 'UTF-8', pack('H4', '\\1'))", $result);
        }
    
        /**
         * @brief 解析json数据格式
         * @param $string String 要解析的json串
         * @return max php数据格式
         */
        public static function decode($string)
        {
            if(strpos($string,"\t") !== false)
            {
                $string = str_replace("\t",'',$string);
            }
    
            
            return json_decode($string,true);
        }
    }

    //使用方法
    $arr = array('str'=>'中文');
    $str = JSON::encode($arr);
    echo $str;
    //结果为{"str":"中文"}