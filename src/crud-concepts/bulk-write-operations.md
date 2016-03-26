# Bulk Write Operations

## Overview

MongoDB provides clients the ability to perform write operations in bulk. Bulk write operations affect a single collection. MongoDB allows applications to determine the acceptable level of acknowledgement required for bulk write operations.

New Bulk methods provide the ability to perform bulk insert, update, and remove operations. MongoDB also supports bulk insert through passing an array of documents to the db.collection.insert() method.

Changed in version 2.6: Previous versions of MongoDB provided the ability for bulk inserts only. With previous versions, clients could perform bulk inserts by passing an array of documents to the db.collection.insert() method. To see the documentation for earlier versions, see Bulk Inserts.

## Ordered vs Unordered Operations

Bulk write operations can be either ordered or unordered. With an ordered list of operations, MongoDB executes the operations serially. If an error occurs during the processing of one of the write operations, MongoDB will return without processing any remaining write operations in the list.

With an unordered list of operations, MongoDB can execute the operations in parallel. If an error occurs during the processing of one of the write operations, MongoDB will continue to process remaining write operations in the list.

Executing an ordered list of operations on a sharded collection will generally be slower than executing an unordered list since with an ordered list, each operation must wait for the previous operation to finish.

## Bulk Methods

To use the Bulk() methods:

Initialize a list of operations using either db.collection.initializeUnorderedBulkOp() or db.collection.initializeOrderedBulkOp().
Add write operations to the list using the following methods:
Bulk.insert()
Bulk.find()
Bulk.find.upsert()
Bulk.find.update()
Bulk.find.updateOne()
Bulk.find.replaceOne()
Bulk.find.remove()
Bulk.find.removeOne()
To execute the list of operations, use the Bulk.execute() method. You can specify the write concern for the list in the Bulk.execute() method.
Once executed, you cannot re-execute the list without reinitializing.
For example,

var bulk = db.items.initializeUnorderedBulkOp();
bulk.insert( { _id: 1, item: "abc123", status: "A", soldQty: 5000 } );
bulk.insert( { _id: 2, item: "abc456", status: "A", soldQty: 150 } );
bulk.insert( { _id: 3, item: "abc789", status: "P", soldQty: 0 } );
bulk.execute( { w: "majority", wtimeout: 5000 } );
For more examples, refer to the reference page for each Bulk Operation Methods method. For information and examples on performing bulk insert using the db.collection.insert(), see db.collection.insert().

SEE ALSO
New Write Operation Protocol

## Bulk Execution Mechanics

When executing an ordered list of operations, MongoDB groups adjacent operations by the operation type. When executing an unordered list of operations, MongoDB groups and may also reorder the operations to increase performance. As such, when performing unordered bulk operations, applications should not depend on the ordering.

Each group of operations can have at most 1000 operations. If a group exceeds this limit, MongoDB will divide the group into smaller groups of 1000 or less. For example, if the bulk operations list consists of 2000 insert operations, MongoDB creates 2 groups, each with 1000 operations.

The sizes and grouping mechanics are internal performance details and are subject to change in future versions.

To see how the operations are grouped for a bulk operation execution, call Bulk.getOperations() after the execution.

For more information, see Bulk.execute().

## Strategies for Bulk Inserts to a Sharded Collection

Large bulk insert operations, including initial data inserts or routine data import, can affect sharded cluster performance. For bulk inserts, consider the following strategies:

### Pre-Split the Collection
If the sharded collection is empty, then the collection has only one initial chunk, which resides on a single shard. MongoDB must then take time to receive data, create splits, and distribute the split chunks to the available shards. To avoid this performance cost, you can pre-split the collection, as described in Split Chunks in a Sharded Cluster.

### Insert to Multiple mongos
To parallelize import processes, send bulk insert or insert operations to more than one mongos instance. For empty collections, first pre-split the collection as described in Split Chunks in a Sharded Cluster.

### Avoid Monotonic Throttling
If your shard key increases monotonically during an insert, then all inserted data goes to the last chunk in the collection, which will always end up on a single shard. Therefore, the insert capacity of the cluster will never exceed the insert capacity of that single shard.

If your insert volume is larger than what a single shard can process, and if you cannot avoid a monotonically increasing shard key, then consider the following modifications to your application:

Reverse the binary bits of the shard key. This preserves the information and avoids correlating insertion order with increasing sequence of values.
Swap the first and last 16-bit words to “shuffle” the inserts.
EXAMPLE
The following example, in C++, swaps the leading and trailing 16-bit word of BSON ObjectIds generated so they are no longer monotonically increasing.

using namespace mongo;
OID make_an_id() {
  OID x = OID::gen();
  const unsigned char *p = x.getData();
  swap( (unsigned short&) p[0], (unsigned short&) p[10] );
  return x;
}

void foo() {
  // create an object
  BSONObj o = BSON( "_id" << make_an_id() << "x" << 3 << "name" << "jane" );
  // now we may insert o into a sharded collection
}