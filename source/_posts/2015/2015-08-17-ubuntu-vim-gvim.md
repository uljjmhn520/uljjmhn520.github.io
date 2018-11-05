---
title: "Ubuntu 15.04 gVim安装及设置"
comments: true
share: true
toc: true
date: "2015-08-17 00:00:01"
categories:
  - other

tags:
  - vim
  - gvim
  - debian

---



从前blog移植过来，暂无摘要，后期再补

<!--more-->

  

安装gVim:

    sudo apt-get install vim-gtk



Ubuntu15.04已经提供了youcompleteme等插件，可以直接安装：

    sudo apt-get install vim-youcompleteme vim-syntastic vim-fugitive


tagbar要用到ctags:

    sudo apt-get install exuberant-ctags
    
CtrlSF需要先安装ag:

    sudo apt-get install silversearcher-ag


安装matchit插件：

    $ sudo apt-get install vim-addon-manager vim-scripts
    $ vim-addons install matchit


通过Vundle安装其他插件


下载Vundle：

    mkdir ~/.vim/bundle
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim


然后编辑~/.vimrc在前面添加如下内容：

//这里差一个图
image
//

然后重新启动gVim并运行：

    :PluginInstall
    
完成插件的最后安装


另外有几个插件还需要做必要的设置：

    " Ctrl+n调用NERDTree
    map <C-n> :NERDTreeToggle<CR>
    " F8调用Tagbar
    nmap <F8> :TagbarToggle<CR>
    " AirLine
    set laststatus=2
    " CtrlSF
    nmap <C-F>n <Plug>CtrlSFCwordPath

另外还需要：

    vim-addons install youcompleteme
   
> 引用地址：http://tieba.baidu.com/p/3602033040