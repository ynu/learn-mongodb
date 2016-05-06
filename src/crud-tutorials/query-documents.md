# 文档查询

## 选取集合中的所有文档

`db.inventory.find( {} )`

`db.inventory.find()`

## 指定值

`db.inventory.find( { type: "snacks" } )`

## 使用查询操作符

查找type字段的值为food或snacks的文档：

`db.inventory.find( { type: { $in: [ 'food', 'snacks' ] } } )`

`$in`是一个查询操作符，使用查询操作符可以执行多种功能的查询

## 查询操作符

### 比较操作符

| 操作符      |     用途 |   用法   | 备注 |
| :--------   | -------- | ------ | ------: |
| $eq         |   相等 |  `{ <field>: { $eq: <value> } }`  | New in version 3.0 |
| $gt         |   大于 |  `{ <field>: { $gt: <value> } }`  | |
| $gte         |   大于等于 |  `{ <field>: { $gte: <value> } }`  | |
| $lt        |   小于 |  `{ <field>: { $lt: <value> } }`  | |
| $lte         |   小于等于 |  `{ <field>: { $lte: <value> } }`  | |
| $ne        |   不等于 |  `{ <field>: { $ne: <value> } }`  | |
| $in        |   指定的值在集合中 |  `{ <field>: { $in: [value1, value2] } }`  | |
| $nin        |   指定的值不在集合中 |  `{ <field>: { $nin: [value1, value2] } }`  |  |



### 逻辑操作符

| 操作符      |     用途 |   用法   | 备注 |
| :--------   | -------- | ------ | ------: |
| $or         |   只要满足其中一个条件即可 |  `db.inventory.find( { $or: [ { quantity: { $lt: 20 } }, { price: 10 } ] } )`  | 查找数量小于20或价格小于10的产品 |
| $and         |   必须满足全部条件 |  `db.inventory.find( { $and: [ { price: { $ne: 1.99 } }, { price: { $exists: true } } ] } )`  | |
| $not         |   条件取反 |  `db.inventory.find( { price: { $not: { $gt: 1.99 } } } )`  | |
| $nor        |   异或条件 |  `db.inventory.find( { $nor: [ { price: 1.99 }, { sale: true } ]  } )`  | |


### 元素操作符

| 操作符      |     用途 |   用法   | 备注 |
| :--------   | -------- | ------ | ------: |
| $exists         |   指定的字段必须存在 |  `db.inventory.find( { qty: { $exists: true, $nin: [ 5, 15 ] } } )`  |  |
| $type         |   指定字段的数据类型 |  `db.collection.find( { field: { $type: -1 } } )`  | Changed in version 3.2. |


### 运算操作符（Evaluation）

| 操作符      |     用途 |   用法   | 备注 |
| :--------   | -------- | ------ | ------: |
| $mod         |   对指定的字段进行取模运算 |  `db.inventory.find( { qty: { $mod: [ 4, 0 ] } } )`  | 查询到的文档的qty字段的值对4取模后余数是0  |
| $regex         |  指定字段需要匹配的正则表达式  |  `{ <field>: { $regex: /pattern/<options> } }`  | |
| $text         |  搜索指定的文本  |  `db.articles.find( { $text: { $search: "bake coffee cake" } } )`  | New in version 2.6 |
| $where         |  指定字段需要匹配的正则表达式  |  `{ <field>: { $regex: /pattern/<options> } }`  | |

### Geosspatial

### Array

| 操作符      |     用途 |   用法   | 备注 |
| :--------   | -------- | ------ | ------: |
| $all         |   Matches arrays that contain all elements specified in the query. |  `db.inventory.find( { tags: { $all: [ "ssl" , "security" ] } } )`  |  |
| $elemMatch         |   Selects documents if element in the array field matches all the specified $elemMatch conditions. |  `db.collection.find( { results: { $elemMatch: { $gte: 80, $lt: 85 } } } )`  | |
| $size         |   Selects documents if the array field is a specified size. |  `db.collection.find( { field: { $size: 2 } } } )`  | |

### Comments

## Specify AND Conditions

A compound query can specify conditions for more than one field in the collection’s documents. Implicitly, a logical AND conjunction connects the clauses of a compound query so that the query selects the documents in the collection that match all the conditions.

In the following example, the query document specifies an equality match on the field type and a less than ($lt) comparison match on the field price:

```
db.inventory.find( { type: 'food', price: { $lt: 9.95 } } )
```

This query selects all documents where the type field has the value 'food' and the value of the price field is less than 9.95. See comparison operators for other comparison operators.

## Specify OR Conditions

Using the $or operator, you can specify a compound query that joins each clause with a logical OR conjunction so that the query selects the documents in the collection that match at least one condition.

In the following example, the query document selects all documents in the collection where the field qty has a value greater than ($gt) 100 or the value of the price field is less than ($lt) 9.95:

```
db.inventory.find(
   {
     $or: [ { qty: { $gt: 100 } }, { price: { $lt: 9.95 } } ]
   }
)
```

## Specify AND as well as OR Conditions

With additional clauses, you can specify precise conditions for matching documents.

In the following example, the compound query document selects all documents in the collection where the value of the type field is 'food' and either the qty has a value greater than ($gt) 100 or the value of the price field is less than ($lt) 9.95:

```
db.inventory.find(
   {
     type: 'food',
     $or: [ { qty: { $gt: 100 } }, { price: { $lt: 9.95 } } ]
   }
)
```

## 内嵌文档

When the field holds an embedded document, a query can either specify an exact match on the embedded document or specify a match by individual fields in the embedded document using the dot notation.

### 内嵌文档的精确匹配
To specify an equality match on the whole embedded document, use the query document { <field>: <value> } where <value> is the document to match. Equality matches on an embedded document require an exact match of the specified <value>, including the field order.

In the following example, the query matches all documents where the value of the field producer is an embedded document that contains only the field company with the value 'ABC123' and the field address with the value '123 Street', in the exact order:

```
db.inventory.find(
    {
      producer:
        {
          company: 'ABC123',
          address: '123 Street'
        }
    }
)
```

### 内嵌文档模糊匹配
Use the dot notation to match by specific fields in an embedded document. Equality matches for specific fields in an embedded document will select documents in the collection where the embedded document contains the specified fields with the specified values. The embedded document can contain additional fields.

In the following example, the query uses the dot notation to match all documents where the value of the field producer is an embedded document that contains a field company with the value 'ABC123' and may contain other fields:

```
db.inventory.find( { 'producer.company': 'ABC123' } )
```

## 数组

When the field holds an array, you can query for an exact array match or for specific values in the array. If the array holds embedded documents, you can query for specific fields in the embedded documents using dot notation.

**If you specify multiple conditions using the `$elemMatch` operator, the array must contain at least one element that satisfies all the conditions**. See Single Element Satisfies the Criteria.

**If you specify multiple conditions without using the `$elemMatch` operator, then some combination of the array elements, not necessarily a single element, must satisfy all the conditions**; i.e. different elements in the array can satisfy different parts of the conditions. See Combination of Elements Satisfies the Criteria.

Consider an inventory collection that contains the following documents:

```
{ _id: 5, type: "food", item: "aaa", ratings: [ 5, 8, 9 ] }
{ _id: 6, type: "food", item: "bbb", ratings: [ 5, 9 ] }
{ _id: 7, type: "food", item: "ccc", ratings: [ 9, 5, 8 ] }
```

### 数组的精确匹配
To specify equality match on an array, use the query document { <field>: <value> } where <value> is the array to match. Equality matches on the array require that the array field match exactly the specified <value>, including the element order.

The following example queries for all documents where the field ratings is an array that holds exactly three elements, 5, 8, and 9, in this order:

```
db.inventory.find( { ratings: [ 5, 8, 9 ] } )
```

The operation returns the following document:

```
{ "_id" : 5, "type" : "food", "item" : "aaa", "ratings" : [ 5, 8, 9 ] }
```

### 匹配数组元素
Equality matches can specify a single element in the array to match. These specifications match if the array contains at least one element with the specified value.

The following example queries for all documents where ratings is an array that contains 5 as one of its elements:
```
db.inventory.find( { ratings: 5 } )
```

The operation returns the following documents:

```
{ "_id" : 5, "type" : "food", "item" : "aaa", "ratings" : [ 5, 8, 9 ] }
{ "_id" : 6, "type" : "food", "item" : "bbb", "ratings" : [ 5, 9 ] }
{ "_id" : 7, "type" : "food", "item" : "ccc", "ratings" : [ 9, 5, 8 ] }
```

### 匹配指定位置的元素
Equality matches can specify equality matches for an element at a particular index or position of the array using the dot notation.

In the following example, the query uses the dot notation to match all documents where the ratings array contains 5 as the first element:
```
db.inventory.find( { 'ratings.0': 5 } )
```

The operation returns the following documents:

```
{ "_id" : 5, "type" : "food", "item" : "aaa", "ratings" : [ 5, 8, 9 ] }
{ "_id" : 6, "type" : "food", "item" : "bbb", "ratings" : [ 5, 9 ] }
```

### Specify Multiple Criteria for Array Elements

#### Single Element Satisfies the Criteria
Use $elemMatch operator to specify multiple criteria on the elements of an array such that at least one array element satisfies all the specified criteria.

The following example queries for documents where the ratings array contains at least one element that is greater than ($gt) 5 and less than ($lt) 9:

```
db.inventory.find( { ratings: { $elemMatch: { $gt: 5, $lt: 9 } } } )
```
The operation returns the following documents, whose ratings array contains the element 8 which meets the criteria:

```
{ "_id" : 5, "type" : "food", "item" : "aaa", "ratings" : [ 5, 8, 9 ] }
{ "_id" : 7, "type" : "food", "item" : "ccc", "ratings" : [ 9, 5, 8 ] }
```

#### Combination of Elements Satisfies the Criteria
The following example queries for documents where the ratings array contains elements that in some combination satisfy the query conditions; e.g., one element can satisfy the greater than 5 condition and another element can satisfy the less than 9 condition, or a single element can satisfy both:

```
db.inventory.find( { ratings: { $gt: 5, $lt: 9 } } )
```

The operation returns the following documents:

```
{ "_id" : 5, "type" : "food", "item" : "aaa", "ratings" : [ 5, 8, 9 ] }
{ "_id" : 6, "type" : "food", "item" : "bbb", "ratings" : [ 5, 9 ] }
{ "_id" : 7, "type" : "food", "item" : "ccc", "ratings" : [ 9, 5, 8 ] }
```

The document with the "ratings" : [ 5, 9 ] matches the query since the element 9 is greater than 5 (the first condition) and the element 5 is less than 9 (the second condition).

### 内嵌文档数组
Consider that the inventory collection includes the following documents:
```
{
  _id: 100,
  type: "food",
  item: "xyz",
  qty: 25,
  price: 2.5,
  ratings: [ 5, 8, 9 ],
  memos: [ { memo: "on time", by: "shipping" }, { memo: "approved", by: "billing" } ]
}

{
  _id: 101,
  type: "fruit",
  item: "jkl",
  qty: 10,
  price: 4.25,
  ratings: [ 5, 9 ],
  memos: [ { memo: "on time", by: "payment" }, { memo: "delayed", by: "shipping" } ]
}
```

#### 使用指定索引位置匹配数组中的内嵌文档
If you know the array index of the embedded document, you can specify the document using the subdocument’s position using the dot notation.

The following example selects all documents where the memos contains an array whose first element (i.e. index is 0) is a document that contains the field by whose value is 'shipping':
```
db.inventory.find( { 'memos.0.by': 'shipping' } )
```

The operation returns the following document:
```
{
   _id: 100,
   type: "food",
   item: "xyz",
   qty: 25,
   price: 2.5,
   ratings: [ 5, 8, 9 ],
   memos: [ { memo: "on time", by: "shipping" }, { memo: "approved", by: "billing" } ]
}
```

#### 匹配数组中内嵌文档的属性值
If you do not know the index position of the document in the array, concatenate the name of the field that contains the array, with a dot (.) and the name of the field in the subdocument.

The following example selects all documents where the memos field contains an array that contains at least one embedded document that contains the field by with the value 'shipping':

```
db.inventory.find( { 'memos.by': 'shipping' } )
```
The operation returns the following documents:
```
{
  _id: 100,
  type: "food",
  item: "xyz",
  qty: 25,
  price: 2.5,
  ratings: [ 5, 8, 9 ],
  memos: [ { memo: "on time", by: "shipping" }, { memo: "approved", by: "billing" } ]
}
{
  _id: 101,
  type: "fruit",
  item: "jkl",
  qty: 10,
  price: 4.25,
  ratings: [ 5, 9 ],
  memos: [ { memo: "on time", by: "payment" }, { memo: "delayed", by: "shipping" } ]
}
```
### Specify Multiple Criteria for Array of Documents

### Single Element Satisfies the Criteria
Use $elemMatch operator to specify multiple criteria on an array of embedded documents such that at least one embedded document satisfies all the specified criteria.

The following example queries for documents where the memos array has at least one embedded document that contains both the field memo equal to 'on time' and the field by equal to 'shipping':
```
db.inventory.find(
   {
     memos:
       {
          $elemMatch:
            {
               memo: 'on time',
               by: 'shipping'
            }
       }
    }
)
```
The operation returns the following document:
```
{
   _id: 100,
   type: "food",
   item: "xyz",
   qty: 25,
   price: 2.5,
   ratings: [ 5, 8, 9 ],
   memos: [ { memo: "on time", by: "shipping" }, { memo: "approved", by: "billing" } ]
}
```
#### Combination of Elements Satisfies the Criteria
The following example queries for documents where the memos array contains elements that in some combination satisfy the query conditions; e.g. one element satisfies the field memo equal to 'on time' condition and another element satisfies the field by equal to 'shipping' condition, or a single element can satisfy both criteria:
```
db.inventory.find(
  {
    'memos.memo': 'on time',
    'memos.by': 'shipping'
  }
)
```
The query returns the following documents:
```
{
  _id: 100,
  type: "food",
  item: "xyz",
  qty: 25,
  price: 2.5,
  ratings: [ 5, 8, 9 ],
  memos: [ { memo: "on time", by: "shipping" }, { memo: "approved", by: "billing" } ]
}
{
  _id: 101,
  type: "fruit",
  item: "jkl",
  qty: 10,
  price: 4.25,
  ratings: [ 5, 9 ],
  memos: [ { memo: "on time", by: "payment" }, { memo: "delayed", by: "shipping" } ]

}
```

### 使用$size
有时候，我们的查询条件中可以需要用到数组元素的个数，这个时候我们就需要使用`$size`操作符。

The $size operator matches any array with the number of elements specified by the argument. For example:

```
db.collection.find( { field: { $size: 2 } } );
```
上述示例将返回集合中所有`field`属性的元素个数是2的文档，例如：`{ field: [ red, green ] }`和 `{ field: [ apple, lime ] }`，而不会返回： `{ field: fruit }` 或 `{ field: [ orange, lemon, grapefruit ] }`。

To match fields with only one element within an array use $size with a value of 1, as follows:

```
db.collection.find( { field: { $size: 1 } } );
```

**$size does not accept ranges of values**. To select documents based on fields with different numbers of elements, create a counter field that you increment when you add elements to a field.

Queries cannot use indexes for the $size portion of a query, although the other portions of a query can use indexes if applicable.


### 使用$all
The $all operator selects the documents where the value of a field is an array that contains all the specified elements. To specify an $all expression, use the following prototype:
```
{ <field>: { $all: [ <value1> , <value2> ... ] } }
```

#### Equivalent to $and Operation
*Changed in version 2.6.*

The $all is equivalent to an $and operation of the specified values; i.e. the following statement:
```
{ tags: { $all: [ "ssl" , "security" ] } }
```
is equivalent to:
```
{ $and: [ { tags: "ssl" }, { tags: "security" } ] }
```

#### Nested Array
*Changed in version 2.6.*

When passed an array of a nested array (e.g. [ [ "A" ] ] ), $all can now match documents where the field contains the nested array as an element (e.g. field: [ [ "A" ], ... ]), or the field equals the nested array (e.g. field: [ "A" ]).

For example, consider the following query [1]:

```
db.articles.find( { tags: { $all: [ [ "ssl", "security" ] ] } } )
```
The query is equivalent to:
```
db.articles.find( { $and: [ { tags: [ "ssl", "security" ] } ] } )
```
which is equivalent to:
```
db.articles.find( { tags: [ "ssl", "security" ] } )
```
As such, the $all expression can match documents where the tags field is an array that contains the nested array [ "ssl", "security" ] or is an array that equals the nested array:
```
tags: [ [ "ssl", "security" ], ... ]
tags: [ "ssl", "security" ]
```
This behavior for $all allows for more matches than previous versions of MongoDB. Earlier versions could only match documents where the field contains the nested array.

#### Performance
Queries that use the $all operator must scan all the documents that match the first element in the $all expression. As a result, even with an index to support the query, the operation may be long running, particularly when the first element in the $all expression is not very selective.

#### Examples
The following examples use the inventory collection that contains the documents:
```
{
   _id: ObjectId("5234cc89687ea597eabee675"),
   code: "xyz",
   tags: [ "school", "book", "bag", "headphone", "appliance" ],
   qty: [
          { size: "S", num: 10, color: "blue" },
          { size: "M", num: 45, color: "blue" },
          { size: "L", num: 100, color: "green" }
        ]
}

{
   _id: ObjectId("5234cc8a687ea597eabee676"),
   code: "abc",
   tags: [ "appliance", "school", "book" ],
   qty: [
          { size: "6", num: 100, color: "green" },
          { size: "6", num: 50, color: "blue" },
          { size: "8", num: 100, color: "brown" }
        ]
}

{
   _id: ObjectId("5234ccb7687ea597eabee677"),
   code: "efg",
   tags: [ "school", "book" ],
   qty: [
          { size: "S", num: 10, color: "blue" },
          { size: "M", num: 100, color: "blue" },
          { size: "L", num: 100, color: "green" }
        ]
}

{
   _id: ObjectId("52350353b2eff1353b349de9"),
   code: "ijk",
   tags: [ "electronics", "school" ],
   qty: [
          { size: "M", num: 100, color: "green" }
        ]
}
```

The following operation uses the $all operator to query the inventory collection for documents where the value of the tags field is an array whose elements include appliance, school, and book:

```
db.inventory.find( { tags: { $all: [ "appliance", "school", "book" ] } } )
```

The above query returns the following documents:

```
{
   _id: ObjectId("5234cc89687ea597eabee675"),
   code: "xyz",
   tags: [ "school", "book", "bag", "headphone", "appliance" ],
   qty: [
          { size: "S", num: 10, color: "blue" },
          { size: "M", num: 45, color: "blue" },
          { size: "L", num: 100, color: "green" }
        ]
}

{
   _id: ObjectId("5234cc8a687ea597eabee676"),
   code: "abc",
   tags: [ "appliance", "school", "book" ],
   qty: [
          { size: "6", num: 100, color: "green" },
          { size: "6", num: 50, color: "blue" },
          { size: "8", num: 100, color: "brown" }
        ]
}
```

If the field contains an array of documents, you can use the $all with the $elemMatch operator.

The following operation queries the inventory collection for documents where the value of the qty field is an array whose elements match the $elemMatch criteria:

```
db.inventory.find( {
                     qty: { $all: [
                                    { "$elemMatch" : { size: "M", num: { $gt: 50} } },
                                    { "$elemMatch" : { num : 100, color: "green" } }
                                  ] }
                   } )
```

The query returns the following documents:

```
{
   "_id" : ObjectId("5234ccb7687ea597eabee677"),
   "code" : "efg",
   "tags" : [ "school", "book"],
   "qty" : [
             { "size" : "S", "num" : 10, "color" : "blue" },
             { "size" : "M", "num" : 100, "color" : "blue" },
             { "size" : "L", "num" : 100, "color" : "green" }
           ]
}

{
   "_id" : ObjectId("52350353b2eff1353b349de9"),
   "code" : "ijk",
   "tags" : [ "electronics", "school" ],
   "qty" : [
             { "size" : "M", "num" : 100, "color" : "green" }
           ]
}
```

The $all operator exists to support queries on arrays. But you may use the $all operator to select against a non-array field, as in the following example:
```
db.inventory.find( { "qty.num": { $all: [ 50 ] } } )
```

However, use the following form to express the same query:

```
db.inventory.find( { "qty.num" : 50 } )
```
Both queries will select all documents in the inventory collection where the value of the num field equals 50.
