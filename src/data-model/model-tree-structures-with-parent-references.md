# 使用父节点引用方式进行树形结构建模

## Overview

本文档描述如何对树形结构数据使用父节点引用的方式进行建模

## Pattern

父节点引用模式将树形结构中的每个节点单独存放到一个文档中，并在每个文档中保存节点的父节点引用。
考虑以下数据结构：

![Tree data model for a sample hierarchy of categories.](data-model-tree.png)

使用父节点方式插入节点：

```
db.categories.insert( { _id: "MongoDB", parent: "Databases" } )
db.categories.insert( { _id: "dbm", parent: "Databases" } )
db.categories.insert( { _id: "Databases", parent: "Programming" } )
db.categories.insert( { _id: "Languages", parent: "Programming" } )
db.categories.insert( { _id: "Programming", parent: "Books" } )
db.categories.insert( { _id: "Books", parent: null } )
```

- 使用此方法可以快速找到节点的父节点：

	`db.categories.findOne( { _id: "MongoDB" } ).parent`

- 对parent字段进行索引可以是查询更快：

	`db.categories.createIndex( { parent: 1 } )`

- 根据父节点可以查询其子节点：

	`db.categories.find( { parent: "Databases" } )`