---
title: start a new debian
comments: true
share: true
toc: true
categories:
  - other
tags:
  - debian
date: 2019-07-01 03:17:19
---

在下常年用debian做开发。最近买了个5手电脑，又一次装了系统，还是会遇到太多问题。太烦了，还是记下来吧！！！

<!-- more -->  

# 前言

* 系统：debian9
* 用途：开发

# 开始吧

## 首先装debian9

有些问题在联网安装的情况下可能不会发生，但我一般都是断网装

## 软件源

* aliyun
    ```bash
    cat <<eof > /etc/apt/source.list
    
    deb http://mirrors.aliyun.com/debian stretch main non-free contrib
    deb-src http://mirrors.aliyun.com/debian stretch main non-free contrib
    
    deb http://mirrors.aliyun.com/debian stretch-updates main non-free contrib
    deb-src http://mirrors.aliyun.com/debian stretch-updates main non-free contrib
    eof
    ```
* us常用
    
    ```bash
    cat <<eof > /etc/apt/source.list
    
    deb http://ftp.us.debian.org/debian/ stretch main
    deb-src http://ftp.us.debian.org/debian/ stretch main
    
    deb http://security.debian.org/debian-security stretch/updates main
    deb-src http://security.debian.org/debian-security stretch/updates main
    
    deb http://ftp.us.debian.org/debian/ stretch-updates main
    deb-src http://ftp.us.debian.org/debian/ stretch-updates main
    eof
  
    ```
* others
    ```bash
    # no no no
    ```

源设置完成后要update 一下

```bash
apt-get update
```

## 创建文件夹
一个临时文件夹，操作都在该目录下执行，完后好一起删了
一个存放app的目录

```bash
mkdir ~/applications/ -p
mkdir ~/tmp -p && cd ~/tmp
```

## 安装代理软件

* apt一波

    ```bash
    apt-get install -y proxychains privoxy
    ```

* ss

    安装sslocal

    ```bash
    git clone https://github.com/uljjmhn555/ssinstaller
    cd ssinstaller
    ./install
    cd ..
    ```
    配置sslocal
    
    ```bash
    vim /etc/shadowsocks/sslocal.json
    # 然后修改相应的地方就
    
    # 启动
    systemctl start sslocal
    systemctl enable sslocal

    ```
    

    
* proxychains

    配置
    
    ```bash
    vim /etc/proxychains.conf
    ## 翻到最后把[ProxyList]里的 socks4 xxxxx改为 socks5 127.0.0.1 1080
    ## 1080 为ss 的端口
  
    ```

* privoxy


## apt安装常用的软件

常用的，后续再加
```bash
apt-get install -y vim git meld mysql-client curl gdebi net-tools
```


## 输入法fcitx

安装之前先看一看是否能正常切换，能切换则可以跳过安装部分

* 安装
    ```bash
    ## 删除默认的
    apt-get remove fcitx* -y
    apt-get autoremove -y
    
    ## 重新安装
    apt-get install fcitx fcitx-table-wbpy -y
    
    ## 这两个不晓得有没有用，只有下次试了
    apt-get install fcitx-ui-classic fcitx-ui-light -y
    
    ```
    完成后，记得把fcitx加入自启动
    以kde 为例
    在 **设置** 》 **系统设置** 》 **开机和关机** 》 **自动启动** 里面添加
* 配置

    ```bash
    ## 环境变量 ，以下5句也不晓得哪些有用，貌似记得是有些窗口不能用fcitx，加入以下变量后就可以了
    
    cat <<eof >> ~/.bashrc
    export LANG=zh_CN.utf8
    export LANGUAGE=zh_CN
    export GTK_IM_MODULE=fcitx
    export XMODIFIERS=@im=fcitx
    export QT_IM_MODULE=fcitx
    eof
    ```




## docker


* docker 安装

    参见[官网](https://docs.docker.com/install/linux/docker-ce/debian/)

    ```bash
    sudo apt-get remove docker docker-engine docker.io containerd runc
    
    sudo apt-get update
    
    sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        software-properties-common -y
    
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
    
    sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) \
       stable"
    
    sudo apt-get update
    
    sudo apt-get install docker-ce docker-ce-cli containerd.io -y
    
    
    ```

* docker-compose安装
    参见[官网](https://docs.docker.com/compose/install/)
    
    ```bash
    sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    
    sudo chmod +x /usr/local/bin/docker-compose
    ```

* 阿里云加速
    ```bash
    
    ## 阿里云加速
    sudo mkdir -p /etc/docker
    sudo tee /etc/docker/daemon.json <<-'EOF'
    {
      "registry-mirrors": ["https://izuikcb5.mirror.aliyuncs.com"]
    }
    EOF
    sudo systemctl daemon-reload
    sudo systemctl restart docker
    ```
    
## jetbrains tool box

```bash
cd ~/tmp
wget https://download-cf.jetbrains.com/toolbox/jetbrains-toolbox-1.15.5387.tar.gz
tar -zxvf jetbrains-toolbox-1.15.5387.tar.gz 
mv jetbrains-toolbox-1.15.5387 ~/applications/jetbrains-toolbox/

# 执行 jetbrains-toolbox/jetbrains-toolbox

```

## virtualbox
```bash
cd ~/tmp/
wget https://download.virtualbox.org/virtualbox/6.0.8/virtualbox-6.0_6.0.8-130520~Debian~stretch_amd64.deb
apt-get install -y linux-headers-$(uname -r) build-essential
### vboxconfig之前最好upgrade一下，并重启
apt-get upgrade -y
apt-get dist-upgrade -y

reboot
vboxconfig
```

## chrome 

```bash

proxychains wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

sudo gdebi google-chrome-stable_current_amd64.deb
```

## charles 

[这是官网](https://www.charlesproxy.com/latest-release/download.do)
这是用apt 安装的，也可以直接下载

* apt方式安装
    ```bash
    wget -q -O - https://www.charlesproxy.com/packages/apt/PublicKey | sudo apt-key add -
    
    sudo sh -c 'echo deb https://www.charlesproxy.com/packages/apt/ charles-proxy main > /etc/apt/sources.list.d/charles.list'
    
    sudo apt-get update
    
    sudo apt-get install charles-proxy
    ```
* wget方式安装
    下次用这个方式安装
    ```bash
    cd ~/tmp/
    wget https://www.charlesproxy.com/assets/release/4.2.8/charles-proxy-4.2.8_amd64.tar.gz
    tar -zxvf charles-proxy-4.2.8_amd64.tar.gz
    cd mv charles ~/applications/

    # 执行 bin/charles
    
  
    ```
* xx

## telegram


## teamviewer 

[这是官网](https://www.teamviewer.com/en/download/linux/)
```bash
proxychains wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
dpkg -i teamviewer_amd64.deb
```

## anydesk

[这是官网](https://anydesk.com/zhs/downloads/linux)
```bash
cd ~/tmp/

# 用proxychains 代理有可能会快点
proxychains wget https://download.anydesk.com/linux/anydesk_5.1.1-1_amd64.deb
dpkg -i anydesk_5.1.1-1_amd64.deb

```

## node

用nvm 安装
```bash
cd ~/
git clone https://github.com/nvm-sh/nvm.git .nvm
cd ~/.nvm
./nvm.sh

cat <<eof >> ~/.bashrc
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
eof

nvm install 10.16
nvm use 10.16

```

## git cz

```bash
npm install -g commitizen

npm install -g cz-conventional-changelog

echo '{ "path": "cz-conventional-changelog" }' > ~/.czrc

```

## termius

这是[官网](https://www.termius.com/linux)

```bash
cd ~/tmp/

wget https://www.termius.com/download/linux/Termius.deb

sudo dpkg -i Termius.deb

apt-get install -f

# 应该用 gdebi Termius.deb 应该也可以，下次试试

```

## git工具

待续