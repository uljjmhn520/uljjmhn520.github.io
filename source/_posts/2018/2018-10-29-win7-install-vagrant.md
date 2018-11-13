---
title: "win7 安装vagrant"
comments: true
share: true
toc: true
date: "2018-10-29 18:15:21"
categories:
  - develop

tags:
  - vagrant
  - windows

---



win7 安装vagrant，做为开发环境，但有时会出错。现将之记录下来。

<!--more-->

 

# 安装

回头补，主要是遇到的错误要先记下来

# 已知错误

## powershell 版本太低

* 错误信息：

        The version of powershell currently installed on this host is less than
        the required minimum version. Please upgrade the installed version of
        powershell to the minimum required version and run the command again.
        
        
          Installed version: 2
        
          Minimum required version: 3
        
    
* 解决方法

        # 参见微软官网
        https://social.technet.microsoft.com/wiki/contents/articles/21016.how-to-install-windows-powershell-4-0.aspx

    但是，由于win7估计快被微软放弃了，不能装了。于是stackoverflow了一下。
    
        https://stackoverflow.com/questions/19902239/how-to-upgrade-powershell-version-from-2-0-to-3-0
        
    1. [Install Chocolatey](https://chocolatey.org/install)
    
            ## 打开cmd,在 cmd中写入以下命令
            @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
    
    2. Run the following commands in CMD
    
            choco install powershell
            choco upgrade powershell
            
    3. restart your computer