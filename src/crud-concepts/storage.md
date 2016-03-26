# Storage

## Data Model

MongoDB stores data in the form of BSON documents, which are rich mappings of keys, or field names, to values. BSON supports a rich collection of types, and fields in BSON documents may hold arrays of values or embedded documents. All documents in MongoDB must be less than 16MB, which is the BSON document size.

Every document in MongoDB is stored in a record which contains the document itself and extra space, or padding, which allows the document to grow as the result of updates.

All records are contiguously located on disk, and when a document becomes larger than the allocated record, MongoDB must allocate a new record. New allocations require MongoDB to move a document and update all indexes that refer to the document, which takes more time than in-place updates and leads to storage fragmentation.

All records are part of a collection, which is a logical grouping of documents in a MongoDB database. The documents in a collection share a set of indexes, and typically these documents share common fields and structure.

In MongoDB the database construct is a group of related collections. Each database has a distinct set of data files and can contain a large number of collections. Also, each database has one distinct write lock, that blocks operations to the database during write operations. A single MongoDB deployment may have many databases.

## Journal

In order to ensure that all modifications to a MongoDB data set are durably written to disk, MongoDB records all modifications to a journal that it writes to disk more frequently than it writes the data files. The journal allows MongoDB to successfully recover data from data files after a mongod instance exits without flushing all changes.

See Journaling Mechanics for more information about the journal in MongoDB.

## Record Allocation Strategies

MongoDB supports multiple record allocation strategies that determine how mongod adds padding to a document when creating a record. Because documents in MongoDB may grow after insertion and all records are contiguous on disk, the padding can reduce the need to relocate documents on disk following updates. Relocations are less efficient than in-place updates, and can lead to storage fragmentation. As a result, all padding strategies trade additional space for increased efficiency and decreased fragmentation.

Different allocation strategies support different kinds of workloads: the power of 2 allocations are more efficient for insert/update/delete workloads; while exact fit allocations is ideal for collections without update and delete workloads.

### Power of 2 Sized Allocations
Changed in version 2.6: For all new collections, usePowerOf2Sizes became the default allocation strategy. To change the default allocation strategy, use the newCollectionsUsePowerOf2Sizes parameter.

mongod uses an allocation strategy called usePowerOf2Sizes where each record has a size in bytes that is a power of 2 (e.g. 32, 64, 128, 256, 512...16777216.) The smallest allocation for a document is 32 bytes. The power of 2 sizes allocation strategy has two key properties:

there are a limited number of record allocation sizes, which makes it easier for mongod to reuse existing allocations, which will reduce fragmentation in some cases.
in many cases, the record allocations are significantly larger than the documents they hold. This allows documents to grow while minimizing or eliminating the chance that the mongod will need to allocate a new record if the document grows.
The usePowerOf2Sizes strategy does not eliminate document reallocation as a result of document growth, but it minimizes its occurrence in many common operations.

### Exact Fit Allocation
The exact fit allocation strategy allocates record sizes based on the size of the document and an additional padding factor. Each collection has its own padding factor, which defaults to 1 when you insert the first document in a collection. MongoDB dynamically adjusts the padding factor up to 2 depending on the rate of growth of the documents over the life of the collection.

To estimate total record size, compute the product of the padding factor and the size of the document. That is:

record size = paddingFactor * <document size>
The size of each record in a collection reflects the size of the padding factor at the time of allocation. See the paddingFactor field in the output of db.collection.stats() to see the current padding factor for a collection.

On average, this exact fit allocation strategy uses less storage space than the usePowerOf2Sizes strategy but will result in higher levels of storage fragmentation if documents grow beyond the size of their initial allocation.

The compact and repairDatabase operations remove padding by default, as do the mongodump and mongorestore. compact does allow you to specify a padding for records during compaction.

## Capped Collections

Capped collections are fixed-size collections that support high-throughput operations that store records in insertion order. Capped collections work like circular buffers: once a collection fills its allocated space, it makes room for new documents by overwriting the oldest documents in the collection.

See Capped Collections for more information.