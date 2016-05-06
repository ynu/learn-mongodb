# 文档插入

In MongoDB, the db.collection.insert() method adds new documents into a collection.

## 插入单个文档

### Insert a document into a collection.
Insert a document into a collection named inventory. The operation will create the collection if the collection does not currently exist.

```
db.inventory.insert(
   {
     item: "ABC1",
     details: {
        model: "14Q3",
        manufacturer: "XYZ Company"
     },
     stock: [ { size: "S", qty: 25 }, { size: "M", qty: 50 } ],
     category: "clothing"
   }
)
```

以上操作将返回：

`WriteResult({ "nInserted" : 1 })`


- `nInserted` 表示被插入的文档的数目
- 如果插入操作发生错误，`WriteResult` 将包括错误信息

### Review the inserted document.
If the insert operation is successful, verify the insertion by querying the collection.

`db.inventory.find()`

The document you inserted should return.

```
{
    "_id" : ObjectId("53d98f133bb604791249ca99"),
    "item" : "ABC1",
    "details" : {
        "model" : "14Q3",
        "manufacturer" : "XYZ Company"
    },
    "stock" : [
        {
            "size" : "S",
            "qty" : 25
        },
        {
            "size" : "M",
            "qty" : 50
        }
    ],
    "category" : "clothing"
}

```

The returned document shows that MongoDB added an _id field to the document. If a client inserts a document that does not contain the _id field, MongoDB adds the field with the value set to a generated ObjectId. The ObjectId values in your documents will differ from the ones shown.

## 插入一组文档

You can pass an array of documents to the db.collection.insert() method to insert multiple documents.

### 创建一个文档数组

Define a variable mydocuments that holds an array of documents to insert.

```
var mydocuments =
    [
      {
        item: "ABC2",
        details: { model: "14Q3", manufacturer: "M1 Corporation" },
        stock: [ { size: "M", qty: 50 } ],
        category: "clothing"
      },
      {
        item: "MNO2",
        details: { model: "14Q3", manufacturer: "ABC Company" },
        stock: [ { size: "S", qty: 5 }, { size: "M", qty: 5 }, { size: "L", qty: 1 } ],
        category: "clothing"
      },
      {
        item: "IJK2",
        details: { model: "14Q2", manufacturer: "M5 Corporation" },
        stock: [ { size: "S", qty: 5 }, { size: "L", qty: 1 } ],
        category: "houseware"
      }
    ];
```

### 插入文档数组
Pass the mydocuments array to the db.collection.insert() to perform a bulk insert.

`db.inventory.insert( mydocuments );`

The method returns a BulkWriteResult object with the status of the operation. A successful insert of the documents returns the following object:

```
BulkWriteResult({
   "writeErrors" : [ ],
   "writeConcernErrors" : [ ],
   "nInserted" : 3,
   "nUpserted" : 0,
   "nMatched" : 0,
   "nModified" : 0,
   "nRemoved" : 0,
   "upserted" : [ ]
})
```

The inserted documents will each have an _id field added by MongoDB.

## Insert Multiple Documents with Bulk

New in version 2.6.

MongoDB provides a Bulk() API that you can use to perform multiple write operations in bulk. The following sequence of operations describes how you would use the Bulk() API to insert a group of documents into a MongoDB collection.

### Initialize a Bulk operations builder.
Initialize a Bulk operations builder for the collection inventory.

var bulk = db.inventory.initializeUnorderedBulkOp();
The operation returns an unordered operations builder which maintains a list of operations to perform. Unordered operations means that MongoDB can execute in parallel as well as in nondeterministic order. If an error occurs during the processing of one of the write operations, MongoDB will continue to process remaining write operations in the list.

You can also initialize an ordered operations builder; see db.collection.initializeOrderedBulkOp() for details.

### Add insert operations to the bulk object.
Add two insert operations to the bulk object using the Bulk.insert() method.

```
bulk.insert(
   {
     item: "BE10",
     details: { model: "14Q2", manufacturer: "XYZ Company" },
     stock: [ { size: "L", qty: 5 } ],
     category: "clothing"
   }
);
bulk.insert(
   {
     item: "ZYT1",
     details: { model: "14Q1", manufacturer: "ABC Company"  },
     stock: [ { size: "S", qty: 5 }, { size: "M", qty: 5 } ],
     category: "houseware"
   }
);
```

### Execute the bulk operation.
Call the execute() method on the bulk object to execute the operations in its list.

```
bulk.execute();
```

The method returns a BulkWriteResult object with the status of the operation. A successful insert of the documents returns the following object:

```
BulkWriteResult({
   "writeErrors" : [ ],
   "writeConcernErrors" : [ ],
   "nInserted" : 2,
   "nUpserted" : 0,
   "nMatched" : 0,
   "nModified" : 0,
   "nRemoved" : 0,
   "upserted" : [ ]
})
```

The nInserted field specifies the number of documents inserted. If the operation encounters an error, the BulkWriteResult object will contain information regarding the error.

## Additional Examples and Methods

For more examples, see db.collection.insert().

The db.collection.update() method, the db.collection.findAndModify(), and the db.collection.save() method can also add new documents. See the individual reference pages for the methods for more information and examples.
