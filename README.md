# Learn MongoDb




* [Introduction to MongoDB](src/introduction/introduction.md)
    * [丰富的数据类型](src/introduction/ff-sjlx.md)
    * [容易扩展](src/introduction/automatic-scaling.md)
    * [丰富的功能](src/introduction/gn.md)
    * [高性能](src/introduction/high-performance.md)
    * [High Availability](src/introduction/high-availability.md)
    * [简便的管理](src/introduction/gl.md)
* [基本概念](src/concepts/README.md)
    * [文档](src/concepts/document.md)
    * [集合](src/concepts/collection.md)
    * [数据库](src/concepts/database.md)
    * [数据类型](src/concepts/data-type.md)
        * [对象id](src/concepts/object-id.md)
* [Installation](src/installation/installation.md)
    * [Install on Windows](src/installation/install-mongodb-on-windows.md)
* [开始使用](src/get-started/README.md)
    * [启动 MongoDB](src/get-started/start-mongodb.md)
    * [Connect to a Database](src/get-started/Connect-to-a-Database.md)
    * [Create a Collection and Insert Documents](src/get-started/create-a-collection-and-insert-documents.md)
    * [Insert Documents using a For Loop](src/get-started/insert-documents-using-a-for-loop.md)
    * [Working with the Cursor](src/get-started/working-with-the-cursor.md)
* [MongoDB CRUD 操作基础](src/crud-concepts/README.md)
    * Read Operations
        * [Read Operations Overview](src/crud-concepts/read-operations-overview.md)
        * [游标](src/crud-concepts/cursors.md)
        * [Query Optimization](src/crud-concepts/query-optimization.md)
        * [Query Plans](src/crud-concepts/query-plans.md)
        * [Distributed Queries](src/crud-concepts/distributed-queries.md)
    * Write Operations
        * [Write Operations Overview](src/crud-concepts/write-operations-overview.md)
        * [Write Concern](src/crud-concepts/write-concern.md)
        * [Atomicity and Transactions](src/crud-concepts/atomicity-and-transactions.md)
        * [Distributed Write Operations](src/crud-concepts/distributed-write-operations.md)
        * [Write Operation Performance](src/crud-concepts/write-operation-performance.md)
        * [Bulk Write Operations](src/crud-concepts/bulk-write-operations.md)
        * [Storage](src/crud-concepts/storage.md)
* [MongoDB CRUD 操作进阶](src/crud-tutorials/README.md)
    * [文档插入](src/crud-tutorials/insert-documents.md)
    * [文档查询](src/crud-tutorials/query-documents.md)
    * [文档修改](src/crud-tutorials/)
    * [文档删除](src/crud-tutorials/)
    * [Limit Fields to Return from a Query](src/crud-tutorials/)
    * [Limit Number of Elements in an Array after an Update](src/crud-tutorials/)
    * [Iterate a Cursor in the mongo Shell](src/crud-tutorials/)
    * [查询性能分析](src/crud-tutorials/)
    * [执行两步提交](src/crud-tutorials/)
    * [Update Document if Current](src/crud-tutorials/)
    * [Create Tailable Cursor](src/crud-tutorials/)
    * [Create an Auto-Incrementing Sequence Field](src/crud-tutorials/)
* [数据模型](src/data-model/README.md)
    * [数据建模概述](src/data-model/introduction.md)
    * [数据模型设计](src/data-model/data-model-design.md)
    * [使用内嵌数据模型对“One-to-One”关系建模](src/data-model/model-embedded-one-to-one-relationships-between-documents.md)
    * [使用内嵌数据模型对“One-to-Many”关系建模](src/data-model/model-embedded-one-to-many-relationships-between-documents.md)
    * [使用引用数据模型对“Many-to-Many”关系建模](src/data-model/model-referenced-many-to-many-relationships-between-documents.md)
    * [使用父节点引用方式进行树形结构建模](src/data-model/model-tree-structures-with-parent-references.md)
    * [使用子节点引用方式进行树形结构建模](src/data-model/model-tree-structures-with-child-references.md)
    * [使用祖先节点数组方式进行树形结构建模](src/data-model/model-tree-structures-with-ancestors-array.md)
    * [使用物化路径方式对树形结构建模](src/data-model/model-tree-structures-with-materialized-paths.md)
    * [使用集合套方式进行树形结构建模](src/data-model/model-tree-structures-with-nested-sets.md)
    * [货币数据建模](src/data-model/model-monetary-data.md)
* [MongoDb 管理](src/administration/README.md)
    - [mongo 进程管理](src/administration/manage-mongodb-processes.md)
    - [数据库操作的性能分析](src/administration/manage-the-database-profiler.md)
    - [数据库备份与恢复](src/administration/backups.md)
    - [创建用户管理员](src/administration/add-user-administrator.md)
    - [创建数据库用户](src/administration/add-user-to-database.md)
    - [创建数据库角色](src/administration/define-roles.md)
    - [为用户指定角色](src/administration/assign-role-to-user.md)
    - [创建数据库角色]()
    - [为用户指定角色]()
    - [移除用户的角色]()
    - [验证用户权限]()
    - [查看角色信息]()
    - [修改用户密码和自定义数据]()
    - [启用身份认证](enable-authentication.md)
- [聚合](src/aggregation/README.md)
    - [聚合管道](src/aggregation/aggregation-pipeline.md)
