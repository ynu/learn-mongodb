# 查询优化（Query Optimization）

索引（Indexes）通过减少读操作在进行查询时所操作的数据的总量有效地提升了查询效率。

## 创建索引以支持读操作

如果我们在被查询的字段上创建一个索引，当我们的应用程序在此字段上进行查询时，索引可以防止查询程序为了找到结果而扫描整个存储空间

### 示例
An application queries the inventory collection on the type field. The value of the type field is user-driven.

```
var typeValue = <someUserInput>;
db.inventory.find( { type: typeValue } );
```

- 由于文档在集合中是无序存放的，因此要根据查询条件找到文档必须在存储系统中逐个比对。
- 为了提升查询的性能，我们需要为inventory集合创建一个在`type`字段上的升序或降序的索引。
- 在shell中，我们可以使用`db.collection.ensureIndex()`方法创建索引：

   `db.inventory.ensureIndex( { type: 1 } )`


## Query Selectivity

Some query operations are not selective. These operations cannot use indexes effectively or cannot use indexes at all.

The inequality operators $nin and $ne are not very selective, as they often match a large portion of the index. As a result, in most cases, a $nin or $ne query with an index may perform no better than a $nin or $ne query that must scan all documents in a collection.

Queries that specify regular expressions, with inline JavaScript regular expressions or $regex operator expressions, cannot use an index with one exception. Queries that specify regular expression with anchors at the beginning of a string can use an index.

## Covering a Query

当同时满足以下两个条件时我们称“索引覆盖了查询”：

- 查询中所有的字段都是一个查询的组成部分
- 查询所返回的所有字段也在同一索引中

例如，inventory集合中存在以下索引：

   `db.inventory.ensureIndex( { type: 1, item: 1 } )`

这个索引将覆盖以下查询：

   ```
   db.inventory.find(
      { type: "food", item:/^c/ },
      { item: 1, _id: 0 }
   )
   ```

对于索引覆盖的查询，查询的投影文档必须显式地使用`_id: 0`把返回结果的`_id`字段排除。

### 性能
Because the index contains all fields required by the query, MongoDB can both match the query conditions and return the results using only the index.

Querying only the index can be much faster than querying documents outside of the index. Index keys are typically smaller than the documents they catalog, and indexes are typically available in RAM or located sequentially on disk.

### Limitations
An index cannot cover a query if:

the query is on a sharded collection and run against a mongos.
Changed in version 2.6.4: In earlier versions, an index cannot cover a query on a sharded collection when run against either a mongos or the primary.

any of the indexed fields in any of the documents in the collection includes an array. If an indexed field is an array, the index becomes a multi-key index index and cannot support a covered query.
any of the returned indexed fields are fields in subdocuments. [2] For example, consider a collection users with documents of the following form:
{ _id: 1, user: { login: "tester" } }
The collection has the following index:
{ "user.login": 1 }
The { "user.login": 1 } index does not cover the following query:
db.users.find( { "user.login": "tester" }, { "user.login": 1, _id: 0 } )
However, the query can use the { "user.login": 1 } index to find matching documents.

### indexOnly

To determine whether a query is a covered query, use the explain() method. If the explain() output displays true for the indexOnly field, an index covers the query, and MongoDB queries only that index to match the query and return the results.

For more information see Measure Index Use.