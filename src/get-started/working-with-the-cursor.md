# 使用游标(Cursor)
当我们对某个集合执行了一次查询（比如，调用了`find`方法）之后：
- MongoDB返回一个包含了查询结果的“游标”，而不是一次性地返回所有查询数据；
- 然后，mongo shell 通过迭代游标，将结果输出到命令行；
- 如果查询结果超过20条，mongo shell只会迭代输出前20条结果，然后等待用户命令。
- 如果用户需要shell继续输出剩余的查询结果，则输入'it'命令即可。

## Iterate over the Cursor with a Loop

1. 查询集合，并将查询结果保存到一个变量中：

    `var c = db.testData.find()`

2. 循环打印出所有结果：

    `while ( c.hasNext() ) printjson( c.next() )`
    - 如果当前游标下还有文档，`hasNext()` 将返回`true`；
    - `next()` 方法返回当前游标的下一个文档；
    - `printjson()` 方法在控制台中按JSON形式打印出文档。

3. 上述操作将输出以下结果：

    ```
    { "_id" : ObjectId("51a7dc7b2cacf40b79990be6"), "x" : 1 }
    { "_id" : ObjectId("51a7dc7b2cacf40b79990be7"), "x" : 2 }
    { "_id" : ObjectId("51a7dc7b2cacf40b79990be8"), "x" : 3 }
    ...
    ```

## Use Array Operations with the Cursor

1. 查询集合，并将查询结果保存到一个变量中：

    `var c = db.testData.find()`

2. 使用`[]`运算符获取指定索引的对象

    `printjson( c [ 4 ] )`

    以上命令将得到输出：

    `{ "_id" : ObjectId("51a7dc7b2cacf40b79990bea"), "x" : 5 }`

3. 试一试：使用for语句打印出前20个文档。

**注意** 当我们通过数组索引操作`[]`运算符读取游标所指向的数据时，服务器首先调用游标对象的`toArray()`方法，并将游标所指向的所有文档读取到内存中，然后`[]`运算符再对内存中的数据进行操作。
因此，当我们使用这种方法读取大量数据的时候，可能会导致内存不足。

## Query for Specific Documents

MongoDB提供丰富的、基于“键/值”的查询语句，用来选择和过滤集合中的文档
在这个示例中，我们为了查询testData中的指定文档，需要为find方法提供一个“查询文档（query document）”作为参数。查询文档包含了用于过滤文档的条件。


在shell中，如果我们需要查找属性x的值是18的文档，可以使用以下语句：

    db.testData.find( { x : 18 } )

MongoDB returns one document that fits this criteria:

    { "_id" : ObjectId("51a7dc7b2cacf40b79990bf7"), "x" : 18 }

## 返回单个文档

- 使用 `findOne()` 方法可以返回单个文档。
- `findOne()`方法与 `find()`方法接收同样的参数，但仅返回找到的第一个文档。
    `db.testData.findOne()`

## 限制查询返回的最大数目

- 为了提高性能，我们可以对查询的返回的最大数目进行限制
- 要指定查询返回的最大数目，可以使用`limit()`方法，例如：

    `db.testData.find().limit(3)`

    返回结果：

    ```
    { "_id" : ObjectId("51a7dc7b2cacf40b79990be6"), "x" : 1 }
    { "_id" : ObjectId("51a7dc7b2cacf40b79990be7"), "x" : 2 }
    { "_id" : ObjectId("51a7dc7b2cacf40b79990be8"), "x" : 3 }
    ```

