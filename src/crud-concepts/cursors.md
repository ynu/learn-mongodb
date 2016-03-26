# 游标（Cursors）

- `db.collection.find()` 返回值就是一个游标，而不是真正的数据的集合
- 要读取数据集合需要对游标进行迭代（iterate）
- However, in the mongo shell, if the returned cursor is not assigned to a variable using the var keyword, then the cursor is automatically iterated up to 20 times(*) to print up to the first 20 documents in the results.
   For example, in the mongo shell, the following read operation queries the inventory collection for documents that have type equal to 'food' and automatically print up to the first 20 matching documents:

   `db.inventory.find( { type: 'food' } );`

   (*) You can use the DBQuery.shellBatchSize to change the number of iteration from the default value 20. See Executing Queries for more information.

## Cursor Behaviors

### Closure of Inactive Cursors
- 默认情况下，服务器会在10分钟之后自动关闭非活动或已经没在用的游标；
- To override this behavior, you can specify the noTimeout wire protocol flag in your query; however, you should either close the cursor manually or exhaust the cursor.
- In the mongo shell, you can set the noTimeout flag:
   `var myCursor = db.inventory.find().addOption(DBQuery.Option.noTimeout);`

### Cursor Isolation
游标并不具备隔离性，因此，由游标返回的数据有可能在被获取前被其他操作修改

### Cursor Batches

- MongoDB 服务器按批将返回结果读入内存中；
- Batch size will not exceed the maximum BSON document size.
- For most queries, the first batch returns 101 documents or just enough documents to exceed 1 megabyte. Subsequent batch size is 4 megabytes.
- To override the default size of the batch, see batchSize() and limit().
- For queries that include a sort operation without an index, the server must load all the documents in memory to perform the sort before returning any results.
- As you iterate through the cursor and reach the end of the returned batch, if there are more results, cursor.next() will perform a getmore operation to retrieve the next batch.
- To see how many documents remain in the batch as you iterate the cursor, you can use the objsLeftInBatch() method, as in the following example:

   ```
   var myCursor = db.inventory.find();
   var myFirstDocument = myCursor.hasNext() ? myCursor.next() : null;
   myCursor.objsLeftInBatch();
   ```

## Cursor Information

The db.serverStatus() method returns a document that includes a metrics field. The metrics field contains a cursor field with the following information:

number of timed out cursors since the last server restart
number of open cursors with the option DBQuery.Option.noTimeout set to prevent timeout after a period of inactivity
number of “pinned” open cursors
total number of open cursors
Consider the following example which calls the db.serverStatus() method and accesses the metrics field from the results and then the cursor field from the metrics field:

db.serverStatus().metrics.cursor
The result is the following document:

{
   "timedOut" : <number>
   "open" : {
      "noTimeout" : <number>,
      "pinned" : <number>,
      "total" : <number>
   }
}