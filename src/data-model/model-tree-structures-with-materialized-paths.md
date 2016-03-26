# 使用物化路径方式对树形结构建模

## Overview

此文档描述如何使用物化路径（Materialized Paths）的方式进行树形结构的建模

## Pattern

物化路径模式使用一个文档存储单个节点，并将节点的父节点以及从此节点到根节点的物化路径存储在文档中。

![Tree data model for a sample hierarchy of categories.](data-model-tree.png)


插入文档：

```
db.categories.insert( { _id: "Books", path: null } )
db.categories.insert( { _id: "Programming", path: ",Books," } )
db.categories.insert( { _id: "Databases", path: ",Books,Programming," } )
db.categories.insert( { _id: "Languages", path: ",Books,Programming," } )
db.categories.insert( { _id: "MongoDB", path: ",Books,Programming,Databases," } )
db.categories.insert( { _id: "dbm", path: ",Books,Programming,Databases," } )
```

- 获取整棵树，并按照层次排序:
	`db.categories.find().sort( { path: 1 } )`

- 使用正则表达式查询节点的所有后代节点：
	- `db.categories.find( { path: /,Programming,/ } )`

- 查询根节点的所有后代节点：
	`db.categories.find( { path: /^,Books,/ } )`

- 要提升查询性能，可以在path字段上创建一个索引：
	`db.categories.createIndex( { path: 1 } )`