# Modify Documents

MongoDB provides the update() method to update the documents of a collection. The method accepts as its parameters:

an update conditions document to match the documents to update,
an update operations document to specify the modification to perform, and
an options document.
To specify the update condition, use the same structure and syntax as the query conditions.

By default, update() updates a single document. To update multiple documents, use the multi option.

## Update Specific Fields in a Document

To change a field value, MongoDB provides update operators, such as $set to modify values.

Some update operators, such as $set, will create the field if the field does not exist. See the individual update operator reference.

### Use update operators to change field values.
For the document with item equal to "MNO2", use the $set operator to update the category field and the details field to the specified values and the $currentDate operator to update the field lastModified with the current date.

```
db.inventory.update(
    { item: "MNO2" },
    {
      $set: {
        category: "apparel",
        details: { model: "14Q3", manufacturer: "XYZ Company" }
      },
      $currentDate: { lastModified: true }
    }
)
```

The update operation returns a WriteResult object which contains the status of the operation. A successful update of the document returns the following object:

```
WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 })
```

The nMatched field specifies the number of existing documents matched for the update, and nModified specifies the number of existing documents modified.

### Update an embedded field.
To update a field within an embedded document, use the dot notation. When using the dot notation, enclose the whole dotted field name in quotes.

The following updates the model field within the embedded details document.

```
db.inventory.update(
  { item: "ABC1" },
  { $set: { "details.model": "14Q2" } }
)
```

The update operation returns a WriteResult object which contains the status of the operation. A successful update of the document returns the following object:

```
WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 })
```

### Update multiple documents.
By default, the update() method updates a single document. To update multiple documents, use the multi option in the update() method.

Update the category field to "apparel" and update the lastModified field to the current date for all documents that have category field equal to "clothing".

```
db.inventory.update(
   { category: "clothing" },
   {
     $set: { category: "apparel" },
     $currentDate: { lastModified: true }
   },
   { multi: true }
)
```

The update operation returns a WriteResult object which contains the status of the operation. A successful update of the document returns the following object:

```
WriteResult({ "nMatched" : 3, "nUpserted" : 0, "nModified" : 3 })
```

## Replace the Document

To replace the entire content of a document except for the `_id` field, pass an entirely new document as the second argument to update().

The replacement document can have different fields from the original document. In the replacement document, you can omit the `_id` field since the `_id` field is immutable. If you do include the `_id` field, it must be the same value as the existing value.

### Replace a document.
The following operation replaces the document with item equal to "BE10". The newly replaced document will only contain the the `_id` field and the fields in the replacement document.

```
db.inventory.update(
   { item: "BE10" },
   {
     item: "BE05",
     stock: [ { size: "S", qty: 20 }, { size: "M", qty: 5 } ],
     category: "apparel"
   }
)
```

The update operation returns a WriteResult object which contains the status of the operation. A successful update of the document returns the following object:

```
WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 })
```

## upsert Option

By default, if no document matches the update query, the update() method does nothing.

However, by specifying upsert: true, the update() method either updates matching document or documents, or inserts a new document using the update specification if no matching document exists.

### Specify upsert: true for the update replacement operation.
When you specify upsert: true for an update operation to replace a document and no matching documents are found, MongoDB creates a new document using the equality conditions in the update conditions document, and replaces this document, except for the `_id` field if specified, with the update document.

The following operation either updates a matching document by replacing it with a new document or adds a new document if no matching document exists.

```
db.inventory.update(
   { item: "TBD1" },
   {
     item: "TBD1",
     details: { "model" : "14Q4", "manufacturer" : "ABC Company" },
     stock: [ { "size" : "S", "qty" : 25 } ],
     category: "houseware"
   },
   { upsert: true }
)
```

The update operation returns a WriteResult object which contains the status of the operation, including whether the db.collection.update() method modified an existing document or added a new document.

```
WriteResult({
    "nMatched" : 0,
    "nUpserted" : 1,
    "nModified" : 0,
    "_id" : ObjectId("53dbd684babeaec6342ed6c7")
})
```

The nMatched field shows that the operation matched 0 documents.

The nUpserted of 1 shows that the update added a document.

The nModified of 0 specifies that no existing documents were updated.

The `_id` field shows the generated `_id` field for the added document.

### Specify an upsert: true for the update specific fields operation.
When you specify an upsert: true for an update operation that modifies specific fields and no matching documents are found, MongoDB creates a new document using the equality conditions in the update conditions document, and applies the modification as specified in the update document.

The following update operation either updates specific fields of a matching document or adds a new document if no matching document exists.

```
db.inventory.update(
   { item: "TBD2" },
   {
     $set: {
        details: { "model" : "14Q3", "manufacturer" : "IJK Co." },
        category: "houseware"
     }
   },
   { upsert: true }
)
```

The update operation returns a WriteResult object which contains the status of the operation, including whether the db.collection.update() method modified an existing document or added a new document.

```
WriteResult({
    "nMatched" : 0,
    "nUpserted" : 1,
    "nModified" : 0,
    "_id" : ObjectId("53dbd7c8babeaec6342ed6c8")
})
```

The nMatched field shows that the operation matched 0 documents.

The nUpserted of 1 shows that the update added a document.

The nModified of 0 specifies that no existing documents were updated.

The `_id` field shows the generated `_id` field for the added document.

## 使用更新操作符（Update Operators)

### 使用操作符的一般形式

```javascript
{
   <operator1>: { <field1>: <value1>, ... },
   <operator2>: { <field2>: <value2>, ... },
   ...
}
```

### Fields
#### $inc

- The $inc operator increments a field by a specified value and has the following form:
  ```javascript
  { $inc: { <field1>: <amount1>, <field2>: <amount2>, ... } }
  ```
- To specify a <field> in an embedded document or in an array, use dot notation.

##### 示例
原文档：
```javascript
{
  _id: 1,
  sku: "abc123",
  quantity: 10,
  metrics: {
    orders: 2,
    ratings: 3.5
  }
}
```

更新语句：
```javascript
db.products.update(
   { sku: "abc123" },
   { $inc: { quantity: -2, "metrics.orders": 1 } }
)
```

结果：
```javascript
{
   "_id" : 1,
   "sku" : "abc123",
   "quantity" : 8,
   "metrics" : {
      "orders" : 3,
      "ratings" : 3.5
   }
}
```

#### $mul
Multiplies the value of the field by the specified amount.

#### $rename
Renames a field.

#### $setOnInsert
Sets the value of a field if an update results in an insert of a document. Has no effect on update operations that modify existing documents.
#### $set
Sets the value of a field in a document.
#### $unset
Removes the specified field from a document.
#### $min
- Only updates the field if the specified value is less than the existing field value.

##### 示例

原文档：
```javascript
{ _id: 1, highScore: 800, lowScore: 200 }
```
更新语句：
```javascript
db.scores.update( { _id: 1 }, { $min: { lowScore: 150 } } )
```
结果：
```javascript
{ _id: 1, highScore: 800, lowScore: 150 }
```

#### $max
Only updates the field if the specified value is greater than the existing field value.

#### $currentDate
- Sets the value of a field to current date, either as a Date or a Timestamp.
- 用法：`{ $currentDate: { <field1>: <typeSpecification1>, ... } }`。`<typeSpecification1>`可以是：
  - `true`，表示设置的值是`Date`类型
  - ` { $type: "timestamp" }`或`{ $type: "date" } `

##### 示例

```javascript
db.users.update(
   { _id: 1 },
   {
     $currentDate: {
        lastModified: true,
        "cancellation.date": { $type: "timestamp" }
     },
     $set: {
        status: "D",
        "cancellation.reason": "user request"
     }
   }
)
```

### 数组
#### $
- 用作位置标识符，标记`update`方法的查询条件中匹配的第一个元素；
- 一般用法：
  ```
  db.collection.update(
     { <array>: value ... },
     { <update operator>: { "<array>.$" : value } }
  )
```

##### 示例
源文档：
```
{ "_id" : 1, "grades" : [ 80, 85, 90 ] }
{ "_id" : 2, "grades" : [ 88, 90, 92 ] }
{ "_id" : 3, "grades" : [ 85, 100, 90 ] }
```
更新语句：
```javascript
db.students.update(
   { _id: 1, grades: 80 },
   { $set: { "grades.$" : 82 } }
)
```

#### $addToSet
Adds elements to an array only if they do not already exist in the set.

##### 示例
```javascript
db.test.update(
   { _id: 1 },
   { $addToSet: {letters: [ "c", "d" ] } }
)
```

#### $pop
移除数组的第一个或最后一个元素

##### 示例
移除第一个元素：
```javascript
db.students.update(
  { _id: 1 },
  { $pop: { scores: -1 } }
)
```
#### $pullAll
Removes all matching values from an array.
#### $pull
Removes all array elements that match a specified query.
#### $pushAll
Deprecated. Adds several items to an array.
#### $push
Adds an item to an array.

### Modifiers

#### $each
Modifies the $push and $addToSet operators to append multiple items for array updates.
#### $slice
Modifies the $push operator to limit the size of updated arrays.
#### $sort
Modifies the $push operator to reorder documents stored in an array.
#### $position
Modifies the $push operator to specify the position in the array to add elements.
