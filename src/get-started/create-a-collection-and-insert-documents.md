# 创建一个集合，并插入文档

In this section, you insert documents into a new collection named testData within the new database named mydb.

关于文档，首先需要了解的是：
- 和数据库一样，MongoDB会在首次使用集合时隐式创建集合，你并不需要在插入文档前手动创建它；
- 由于MongoDB使用的是动态架构（dynamic schemas），你也不需要在插入文档前为集合指定架构。

在命令行中创建集合并插入文档的主要步骤：

1. 确定当前使用的数据库：`db`；
2. 如果当前数据库不对，则使用`use`命令进行切换： `use mydb`；
3. 使用JavaScript语言创建两个文档，分别命名为 `j` 和 `k`：

    ```
    j = { name : "mongo" }
    k = { x : 3 }
    ```

4. 使用`insert`方法将`j`和`k`分别插入到集合中

    ```
    db.testData.insert( j )
    db.testData.insert( k )
    ```

5. 当插入了第一个文档后，服务器将自动创建`mydb`数据和`testData`集合，可以使用`show dbs`命令和`show collections`命令查看服务器的数据库列表和当前数据库的集合列表

6. 使用`find`方法可以查询指定集合中的所有文档：

    `db.testData.find()`

    执行以上命令后返回的结果是：

    ```
    { "_id" : ObjectId("4c2209f9f3924d31102bd84a"), "name" : "mongo" }
    { "_id" : ObjectId("4c2209fef3924d31102bd84b"), "x" : 3 }
    ```

在MongoDB中，所有文档都有一个带有唯一值的 `_id` 字段，此字段不需要用户显示地指定，系统会在文档被插入之前自动添加。
