# Remove Documents

In MongoDB, the db.collection.remove() method removes documents from a collection. You can remove all documents from a collection, remove all documents that match a condition, or limit the operation to remove just a single document.

This tutorial provides examples of remove operations using the db.collection.remove() method in the mongo shell.

## Remove All Documents

To remove all documents from a collection, pass an empty query document {} to the remove() method. The remove() method does not remove the indexes.

The following example removes all documents from the inventory collection:

db.inventory.remove({})
To remove all documents from a collection, it may be more efficient to use the drop() method to drop the entire collection, including the indexes, and then recreate the collection and rebuild the indexes.

## Remove Documents that Match a Condition

To remove the documents that match a deletion criteria, call the remove() method with the <query> parameter.

The following example removes all documents from the inventory collection where the type field equals food:

db.inventory.remove( { type : "food" } )
For large deletion operations, it may be more efficient to copy the documents that you want to keep to a new collection and then use drop() on the original collection.

## Remove a Single Document that Matches a Condition

To remove a single document, call the remove() method with the justOne parameter set to true or 1.

The following example removes one document from the inventory collection where the type field equals food:

db.inventory.remove( { type : "food" }, 1 )
To delete a single document sorted by some specified order, use the findAndModify() method.