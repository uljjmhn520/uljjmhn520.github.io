---
title: "mysqli的参数化查询，学习一下，马上就用"
comments: true
share: true
toc: true
date: "2015-05-26 00:00:01"
categories:
  - develop

tags:
  - mysql
  - safety

---



从前blog移植过来，暂无摘要，后期再补

<!--more-->

  

$db = new mysqli("localhost", "user", "pass", "database");

$stmt = $mysqli -> prepare("SELECT priv FROM testUsers WHERE username=? AND password=?");

$stmt -> bind_param("ss", $user, $pass);

$stmt -> execute();

以这个为基础，封装成类