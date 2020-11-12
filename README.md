# bffast

bffast快速开发平台(spring boot 2.2.*版) - 快速搭建单应用后台服务

##目前平台技术栈为：
+ Mybatis Plus
+ Shiro
+ Swagger
+ Redis
+ Netty
+ ftp
+ log4j2日志框架
+ quartz 
+ lombok
+ i18n国际化
+ 线程池
+ 开放(三方)接口

___

##规范

领域对象规范
* 数据实体 - xxxDO, xxx为表名 
* 数据传输对象 - xxxDTO, xxx为业务领域相关名称
* 展示对象 - xxxVO, xxx对应页面内容

Dao接口规范
* insert
* batchInsert
* selectOne
* selectById
* count
* selectList
* update
* deleteById

Service接口规范
* save
* getById
* getByXXX
* getList - 不分页
* getListPage - 分页
* update
* remove

___

说明：如不需要相关模块，请移除module下相关模块、pom中maven依赖以及相关配置
