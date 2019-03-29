---
title: 【转】Shell脚本中实现切换用户并执行命令操作
comments: true
share: true
toc: true
date: 2018-11-08 09:30:41
categories:
  - develop
tags:
  - bash
---

这篇文章主要介绍了Shell脚本中实现切换用户并执行命令操作,看了示例代码就秒懂了,原来如此简单,需要的朋友可以参考下

<!-- more -->  

今天公司同事来找到我说要在服务器上用另外一个用户执行python脚本,但设置到crontab里却老是root用户来执行,为了省事我就想了一个偷懒的办法,就是用shell脚本切换到那个用户,然后去执行那个python脚本.好了,这篇文章我只演示怎么用shell脚本切换到其他用户执行命令.

系统:centos 5.x

脚本内容:

cat test.sh

```bash
#!/bin/bash
su - test <<EOF
pwd;
exit;
EOF
```

执行结果:

```bash
$ ./test.sh
/home/test


```

当然也可以用下面的命令来执行

```bash
$ su - test -c "pwd"
/home/test
```


```bash
$ su - test -c "whoami"
test
```

ps:

切换用户只执行一条命令的可以用: su - oracle -c command

切换用户执行一个shell文件可以用:su - oracle -s /bin/bash shell.sh

好了,就这样吧.


> 本文转自： [https://www.jb51.net/article/59255.htm](https://www.jb51.net/article/59255.htm)