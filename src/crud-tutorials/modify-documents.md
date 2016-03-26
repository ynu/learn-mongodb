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
The update operation returns a WriteResult object which contains the status of the operation. A successful update of the document returns the following object:

WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 })
The nMatched field specifies the number of existing documents matched for the update, and nModified specifies the number of existing documents modified.

### Update an embedded field.
To update a field within an embedded document, use the dot notation. When using the dot notation, enclose the whole dotted field name in quotes.

The following updates the model field within the embedded details document.

db.inventory.update(
  { item: "ABC1" },
  { $set: { "details.model": "14Q2" } }
)
The update operation returns a WriteResult object which contains the status of the operation. A successful update of the document returns the following object:

WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 })

### Update multiple documents.
By default, the update() method updates a single document. To update multiple documents, use the multi option in the update() method.

Update the category field to "apparel" and update the lastModified field to the current date for all documents that have category field equal to "clothing".

db.inventory.update(
   { category: "clothing" },
   {
     $set: { category: "apparel" },
     $currentDate: { lastModified: true }
   },
   { multi: true }
)
The update operation returns a WriteResult object which contains the status of the operation. A successful update of the document returns the following object:

WriteResult({ "nMatched" : 3, "nUpserted" : 0, "nModified" : 3 })

## Replace the Document

To replace the entire content of a document except for the _id field, pass an entirely new document as the second argument to update().

The replacement document can have different fields from the original document. In the replacement document, you can omit the _id field since the _id field is immutable. If you do include the _id field, it must be the same value as the existing value.

### Replace a document.
The following operation replaces the document with item equal to "BE10". The newly replaced document will only contain the the _id field and the fields in the replacement document.

db.inventory.update(
   { item: "BE10" },
   {
     item: "BE05",
     stock: [ { size: "S", qty: 20 }, { size: "M", qty: 5 } ],
     category: "apparel"
   }
)
The update operation returns a WriteResult object which contains the status of the operation. A successful update of the document returns the following object:

WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 })

## upsert Option

By default, if no document matches the update query, the update() method does nothing.

However, by specifying upsert: true, the update() method either updates matching document or documents, or inserts a new document using the update specification if no matching document exists.

### Specify upsert: true for the update replacement operation.
When you specify upsert: true for an update operation to replace a document and no matching documents are found, MongoDB creates a new document using the equality conditions in the update conditions document, and replaces this document, except for the _id field if specified, with the update document.

The following operation either updates a matching document by replacing it with a new document or adds a new document if no matching document exists.

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
The update operation returns a WriteResult object which contains the status of the operation, including whether the db.collection.update() method modified an existing document or added a new document.

WriteResult({
    "nMatched" : 0,
    "nUpserted" : 1,
    "nModified" : 0,
    "_id" : ObjectId("53dbd684babeaec6342ed6c7")
})
The nMatched field shows that the operation matched 0 documents.

The nUpserted of 1 shows that the update added a document.

The nModified of 0 specifies that no existing documents were updated.

The _id field shows the generated _id field for the added document.

### Specify an upsert: true for the update specific fields operation.
When you specify an upsert: true for an update operation that modifies specific fields and no matching documents are found, MongoDB creates a new document using the equality conditions in the update conditions document, and applies the modification as specified in the update document.

The following update operation either updates specific fields of a matching document or adds a new document if no matching document exists.

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
The update operation returns a WriteResult object which contains the status of the operation, including whether the db.collection.update() method modified an existing document or added a new document.

WriteResult({
    "nMatched" : 0,
    "nUpserted" : 1,
    "nModified" : 0,
    "_id" : ObjectId("53dbd7c8babeaec6342ed6c8")
})
The nMatched field shows that the operation matched 0 documents.

The nUpserted of 1 shows that the update added a document.

The nModified of 0 specifies that no existing documents were updated.

The _id field shows the generated _id field for the added document.

## Additional Examples and Methods

For more examples, see Update examples in the db.collection.update() reference page.

The db.collection.findAndModify() and the db.collection.save() method can also modify existing documents or insert a new one. See the individual reference pages for the methods for more information and examples.