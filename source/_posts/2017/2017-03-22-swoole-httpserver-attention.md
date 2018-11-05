---
layout: post
title: "swoole 做 httpserver 整合phalcon "
description: ""
category : "@web"
date: "2017-03-22 00:00:02"
tags: [ swoole,php,phalcon]
---
从前blog移植过来，暂无摘要，后期再补
<!-- more -->  



### 在整合的时候遇到的一些问题，先列出来，害怕忘了


#### mysql连接断开问题，可能redis等也存在 

* 原因找到了

    1. mysql 客户端运行时，如果长时间没有操作会自动断开
    
    2. swoole 开启的服务程序长时间运行，常驻内存
    
    3. phalcon 里的model 的 find findFirst 方法里面，不能选择di，而只能使用默认 di
        
        以下是model的一段源代码
        
            ......
            public static function findFirst(var parameters = null) -> <Model>
            {
                var params, builder, query, bindParams, bindTypes, cache,
                        dependencyInjector, manager;
    
                let dependencyInjector = Di::getDefault();
                let manager = <ManagerInterface> dependencyInjector->getShared("modelsManager");
    
                if typeof parameters != "array" {
                    let params = [];
                    if parameters !== null {
                            let params[] = parameters;
                    }
                } else {
                    let params = parameters;
                }
            ......
            
    4. 毋庸置疑，Di::getDefault() 中的 default 肯定是一个静态属性
    
        以下是 di 的一段源代码
             ......
             
             /**
             * Latest DI build
             */
            protected static _default;
            
            ......
            
            /**
             * Return the latest DI created
             */
            public static function getDefault() -> <DiInterface>
            {
                    return self::_default;
            }
            ......
            
        也就是说在cli中（也就是server端）调用后，_default 这个属性就会一直在内存中，mysql的客户端（比如pdo）
        由于注入到di中（di->set('db',{PdoAdapter})），并且phalcon在取db时，用的
        是di->getShared('db',{db})，以下是 phalcn/model/manager 中的一段代码
        
            ......
            /**
             * Returns the connection to read or write data related to a model depending on the connection services.
             */
            protected function _getConnection(<ModelInterface> model, connectionServices) -> <AdapterInterface>
            {       
                var dependencyInjector, service, connection;
                
                let service = this->_getConnectionService(model, connectionServices);
                
                let dependencyInjector = <DiInterface> this->_dependencyInjector;
                if typeof dependencyInjector != "object" {
                    throw new Exception("A dependency injector container is required to obtain the services related to the ORM");
                }
                
                /**
                 * Request the connection service from the DI
                 */ 
                let connection = <AdapterInterface> dependencyInjector->getShared(service);
                
                if typeof connection != "object" {
                    throw new Exception("Invalid injected connection service");
                }
                
                return connection;
            }
            
            ......
            
    5. 综上所述，如果app长时间没有对数据库的操作，他们之间的连接就会断开，
    并且不会自动重连，还有一种情况，就是如果mysql服务重启了，连接也不会重连
    而常规的apache/nginx方式就不会出现这个问题，毕竟每次请求都会新建一个客户端
    
    6. 现在问题找到了，该说解决方法了，方法很多，只是难易问题
    
        1. 在每次与mysql 交互时用，如果返回失败，检查错误代码，如果为 2006 / 2013，
        表示连接失败，再执行一次连接操作。
            
            这种方法的思路就是很简单，就是没连上就重连
        
            这明显不可能在业务层实现，但phalcon的源码不是php的，所以dao层也不太方便修改
        
        2. 不用findFirst 这类静态方法，而用builder 来操作数据。
        
            这样虽能解决问题，但原本一句话能解决的问题需要写多句才能实现。我目前临时用的这种
            方式，在model 中封装了两个方法来暂代。
            
        3. 其实和2差不多，只是在 modelManager 和 di 上做文章
        
            也就是说，操作数据库时，不用默认的di（即常驻内存的di），而选用每次
            请求生成的di
            
                public function findOne($parameters = null)
                {
            
                    /** @var DiInterface $di */
                    $di = $this->_dependencyInjector;
            
                    if(!$di || !($di instanceof DiInterface)){
                        throw new Model\Exception('di must be set in model');
                    }
            
                    /** @var Model\Manager $manager */
                    $manager = $di->getShared("modelsManager");
            
                    if(!is_array($parameters)){
                        $params = [];
                        if ($parameters !== null) {
                            $params[] = $parameters;
                        }
                    }else{
                        $params = $parameters;
                    }
            
                    /**
                     * Builds a query with the passed parameters
                     */
                    $builder = $manager->createBuilder($params);
                    $builder->from(get_called_class());
            
                    /**
                     * We only want the first record
                     */
                    $builder->limit(1);
            
                    /** @var Model\Query $query */
                    $query = $builder->getQuery();
            
                    /**
                     * Check for bind parameters
                     */
                    $bindParams = isset($bindParams['bind']) ? $bindParams['bind'] : null;
                    if($bindParams){
                        if (is_array($bindParams)) {
                            $query->setBindParams($bindParams, true);
                        }
            
                        if(isset($params["bindTypes"]) ){
                            if(is_array($params["bindTypes"])){
                                $query->setBindTypes($params["bindTypes"], true);
                            }
                        }
                    }
            
            
                    /**
                     * Pass the cache options to the query
                     */
                    if(isset($params['cache'])){
                        $query->cache($params['cache']);
                    }
            
                    /**
                     * Return only the first row
                     */
                    $query->setUniqueRow(true);
            
                    /**
                     * Execute the query passing the bind-params and casting-types
                     */
                    return $query->execute();
                }
            
                public function findAll($parameters = null)
                {
                    /** @var DiInterface $di */
                    $di = $this->_dependencyInjector;
            
                    if(!$di || !($di instanceof DiInterface)){
                        throw new Model\Exception('di must be set in model');
                    }
            
            
                    /** @var Model\Manager $manager */
                    $manager = $di->getShared("modelsManager");
            
                    if (!is_array($parameters)) {
                        $params = [];
                        if ($parameters !== null) {
                            $params[] = $parameters;
                        }
                    }else{
                        $params = $parameters;
                    }
            
                    /**
                     * Builds a query with the passed parameters
                     */
            
                    $builder = $manager->createBuilder($params);
                    $builder->from(get_called_class());
            
                    /** @var Model\Query $query */
                    $query = $builder->getQuery();
            
                    /**
                     * Check for bind parameters
                     */
                    if (isset($params['bind'])) {
                        if (is_array($params['bind'])) {
                            $query->setBindParams($params['bind'], true);
                        }
                        if (isset($params['bindTypes'])) {
                            if (is_array($params['bindTypes'])) {
                                $query->setBindTypes($params['bindTypes'],true);
                            }
                        }
                    }
            
                    /**
                     * Pass the cache options to the query
                     */
                    if (isset($params['cache'])) {
                        $query->cache($params['cache']);
                    }
            
                    /**
                     * Execute the query passing the bind-params and casting-types
                     */
                    /** @var Model\ResultsetInterface|Model\Resultset\Complex $resultSet */
                    $resultSet = $query->execute();
            
                    /**
                     * Define an hydration mode
                     */
                    if (is_object($resultSet)) {
                        if (isset($params['hydration'])) {
                            $resultSet->setHydrateMode($params['hydration']);
                        }
                    }
            
                    return $resultSet;
                }

            这样做后代码的前后对比，以findFirst为例
            
                # 没改之前
            
                $row = Model::findFirst([...]);
                
                # 改了之后
                
                $row = (new Model(null,$di))->findOne([...]);
                
                # 或者用 modelManager 来生成
                $row = $this->modelManager->load(Model::class)->findOne([...]); 
                
                # 使用这种方式的前提是在注入modelManager服务时，就应该把di注入到modelManager中
                
                # 1. 注入 modelManager
                $di->setShared('modelManager',function() use($di){
                    $manager = new Phalcon\Mvc\Model\Manager();
                    $manager->setDi($di);
                    return $manager;
                });
                
                # 2. findOne
                $row = $this->modelManager->load(Model::class)->findOne([...]); 
                
            如果要实例化一个模型，做 dml 操作，如save
            
                # load的参数2，如果为false，表示不新实例化一个模型，而沿用一个曾经实例化过的模型，
                # 目前没有没有测试为false 的情况来做dml操作，但为了不必要的麻烦，暂时不用false的情况
                $row = $this->modelManager->load(Model::class，true); 
                $row->name = 'jim green';
                $row->age  = '13';
                $row->save();
                
                # 或者
                
                $row = new Model(['name'=>'tom','age'=>'13'],$di);
                $row->save();
            
        4. 还在思考其它方法
            
           目前想的是，既然要把swoole 和phalcon 合起来，就避免不了两个或多个di。
           所以，我想把model这部分重写了，去掉取默认di的做法。而多个应用之各自分别
           设置不同di，只不过，可能脑壳容易混乱。


#### get post cookie header 的 get/set 问题 

#### session 的 get/set 问题 

### 解决方法有空再写出来
