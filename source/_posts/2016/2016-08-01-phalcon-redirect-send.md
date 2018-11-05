---
title: "phalcon 的跳转问题"
comments: true
share: true
toc: true
date: "2016-08-01 00:00:01"
categories:
  - web

tags:
  - phalcon

---



从前blog移植过来，暂无摘要，后期再补

<!--more-->

  


今天又遇到那个那老问题了，phalcon 跳转（response->redirect(...)） 时，仍然会执行后续代码的问题

## 例1

    public function indexAction()
        {

            //判断条件
            if(true){
                $this->response->redirect('http://www.qq.com');
            }

            //new 一个 Phalcon\Logger\Adapter\File() ,
            $logger = new File($this->config->application->logsDir.'debug.log');

            // log
            $logger->log('hello world ');

        }

执行该脚本，结果就是跳转到 www.qq.com ，但是 $logger 也仍然会运行，记录下 hello world。
这种在action  的 redirect 还比较好解决，直接在 redirect 那里 return 就可以了

比如

    public function indexAction()
    {

        //判断条件
        if(true){
            return $this->response->redirect('http://www.qq.com');

            //或者这样

            $this->response->redirect('http://www.qq.com');
            return;
        }

        //new 一个 Phalcon\Logger\Adapter\File() ,
        $logger = new File($this->config->application->logsDir.'debug.log');

        // log
        $logger->log('hello world ');

    }

但还有一种情况，就是比如判断用户权限时，就可会把 redirect 写在 initialize 或者 beforeExecuteRoute 等地方

    public function initialize()
    {
        $this->response->redirect('http://www.baidu.com');
        return;
    }


    public function indexAction()
    {

        $this->response->redirect('http://www.qq.com');

        //new 一个 Phalcon\Logger\Adapter\File() ,
        $logger = new File($this->config->application->logsDir.'debug.log');

        // log
        $logger->log('hello world ');

    }

执行后，就跳转到了 qq 而不是 baidu ， logger 也正常 log 。而且 initialize 里面的加了 return 也没有效果。

但是，如果把 return 改成exit 的话，就直接是空页面。

查了一下 Response 的接口，发现里面的两个方法

    /**
     * Prints out HTTP response to the client
     *
     * @return ResponseInterface
     */
    public function send();

    /**
     * Sends headers to the client
     *
     * @return ResponseInterface
     */
    public function sendHeaders();

觉得可能 Response 只是设置了跳转url ，而实际并没有发送header。
于是尝试了一下,在 redirect 方法后面加了 send() 或者 sendHeaders() 执行了一下。
结果还是不成功，仍然会执行后续代码。
再然后，加了一个exit ，就成功了。记录一下代码！！！

    public function initialize()
    {
        //$this->response->redirect('http://www.baidu.com')->sendHeaders();
        $this->response->redirect('http://www.baidu.com')->send();
        exit();
    }

    public function indexAction()
    {

        $this->response->redirect('http://www.qq.com');

        //new 一个 Phalcon\Logger\Adapter\File() ,
        $logger = new File($this->config->application->logsDir.'debug.log');

        // log
        $logger->log('hello world ');

    }

上面的 send() 和 sendHeaders() 都可以用，关于这两个的区别，暂时没有时间研究。先记在这里吧，有时间再看！