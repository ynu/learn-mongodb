# Insert Documents using a For Loop


## Insert new documents into the testData collection.
From the mongo shell, use the for loop. If the testData collection does not exist, MongoDB will implicitly create the collection.

```
for (var i = 1; i <= 25; i++) {
   db.testData.insert( { x : i } )
}

```

## Query the collection.
Use `find()` to query the collection:

`db.testData.find()`

The mongo shell displays the first 20 documents in the collection. Your ObjectId values will be different:

```
{ "_id" : ObjectId("53d7be30242b692a1138ac7d"), "x" : 1 }
{ "_id" : ObjectId("53d7be30242b692a1138ac7e"), "x" : 2 }
{ "_id" : ObjectId("53d7be30242b692a1138ac7f"), "x" : 3 }
{ "_id" : ObjectId("53d7be30242b692a1138ac80"), "x" : 4 }
{ "_id" : ObjectId("53d7be30242b692a1138ac81"), "x" : 5 }
{ "_id" : ObjectId("53d7be30242b692a1138ac82"), "x" : 6 }
{ "_id" : ObjectId("53d7be30242b692a1138ac83"), "x" : 7 }
{ "_id" : ObjectId("53d7be30242b692a1138ac84"), "x" : 8 }
{ "_id" : ObjectId("53d7be30242b692a1138ac85"), "x" : 9 }
{ "_id" : ObjectId("53d7be30242b692a1138ac86"), "x" : 10 }
{ "_id" : ObjectId("53d7be30242b692a1138ac87"), "x" : 11 }
{ "_id" : ObjectId("53d7be30242b692a1138ac88"), "x" : 12 }
{ "_id" : ObjectId("53d7be30242b692a1138ac89"), "x" : 13 }
{ "_id" : ObjectId("53d7be30242b692a1138ac8a"), "x" : 14 }
{ "_id" : ObjectId("53d7be30242b692a1138ac8b"), "x" : 15 }
{ "_id" : ObjectId("53d7be30242b692a1138ac8c"), "x" : 16 }
{ "_id" : ObjectId("53d7be30242b692a1138ac8d"), "x" : 17 }
{ "_id" : ObjectId("53d7be30242b692a1138ac8e"), "x" : 18 }
{ "_id" : ObjectId("53d7be30242b692a1138ac8f"), "x" : 19 }
{ "_id" : ObjectId("53d7be30242b692a1138ac90"), "x" : 20 }
Type "it" for more
```

## Iterate through the cursor.
The `find()` method returns a cursor. To iterate the cursor and return more documents, type `it` in the mongo shell. The shell will exhaust the cursor and return these documents:

```
{ "_id" : ObjectId("53d7be30242b692a1138ac91"), "x" : 21 }
{ "_id" : ObjectId("53d7be30242b692a1138ac92"), "x" : 22 }
{ "_id" : ObjectId("53d7be30242b692a1138ac93"), "x" : 23 }
{ "_id" : ObjectId("53d7be30242b692a1138ac94"), "x" : 24 }
{ "_id" : ObjectId("53d7be30242b692a1138ac95"), "x" : 25 }
```