---
title: "[转]设置 Debian/Ubuntu 不允许使用 root ssh 登陆"
comments: true
share: true
toc: true
date: "2015-09-01 00:00:01"
categories:
  - linux

tags:
  - debian
  - login
  - root
  - ssh

---



从前blog移植过来，暂无摘要，后期再补

<!--more-->

  

基本上, root 密碼是什麼我也記不起來(都是亂打的), 不過直接於 ssh 擋掉還是較安全點~(Ubuntu / Debian Linux 預設是允許 root ssh login 的)


設定不允許 root ssh 登入


    vim /etc/ssh/sshd_config

找到 PermitRootLogin yes

改成 PermitRootLogin no

    /etc/init.d/ssh restart 
    
即可.



修改 ssh Port



若有要改跑其它 Port, 一樣於 sshd_config 找到 Port, 將 22 改成想要的 Port number 即可.



限定特定帳號登入



若只允許某些帳號登入:


    vim /etc/pam.d/sshd

    # account  required     pam_access.so
    
拿掉註解

    account required pam_access.so

vim /etc/security/access.conf # 照範例設定即可.

這是另一種方法, 此方法我沒試過(摘錄自: SSH 的一些安全小技巧):

    vi /etc/pam.d/sshd
    
    # 加入此行
    auth required pam_listfile.so item=user sense=allow file=/etc/ssh_users onerr=fail

echo user1 >> /etc/ssh_users # user1 就是你要允許的 user 名稱 (一個帳號一行)

以下为自己加上的：

debian 有些版本默认不让root账户登陆，比如debian 8 



    vim /etc/ssh/sshd_config

找到 PermitRootLogin xxxxx
debian 8 里面是 PermitRootLogin without-password
改成 PermitRootLogin yes
保存后，运行

    /etc/init.d/ssh restart

> 引用地址：http://blog.longwin.com.tw/2008/10/security-debian-ubuntu-linux-deny-root-login-2008/