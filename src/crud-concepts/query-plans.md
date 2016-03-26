# Query Plans

The MongoDB query optimizer processes queries and chooses the most efficient query plan for a query given the available indexes. The query system then uses this query plan each time the query runs.

The query optimizer only caches the plans for those query shapes that can have more than one viable plan.

The query optimizer occasionally reevaluates query plans as the content of the collection changes to ensure optimal query plans. You can also specify which indexes the optimizer evaluates with Index Filters.

You can use the explain() method to view statistics about the query plan for a given query. This information can help as you develop indexing strategies.

## Query Optimization

To create a new query plan, the query optimizer:

runs the query against several candidate indexes in parallel.
records the matches in a common results buffer or buffers.
If the candidate plans include only ordered query plans, there is a single common results buffer.
If the candidate plans include only unordered query plans, there is a single common results buffer.
If the candidate plans include both ordered query plans and unordered query plans, there are two common results buffers, one for the ordered plans and the other for the unordered plans.
If an index returns a result already returned by another index, the optimizer skips the duplicate match. In the case of the two buffers, both buffers are de-duped.
stops the testing of candidate plans and selects an index when one of the following events occur:
An unordered query plan has returned all the matching results; or
An ordered query plan has returned all the matching results; or
An ordered query plan has returned a threshold number of matching results:
Version 2.0: Threshold is the query batch size. The default batch size is 101.
Version 2.2: Threshold is 101.
The selected index becomes the index specified in the query plan; future iterations of this query or queries with the same query pattern will use this index. Query pattern refers to query select conditions that differ only in the values, as in the following two queries with the same query pattern:

db.inventory.find( { type: 'food' } )
db.inventory.find( { type: 'utensil' } )

## Query Plan Revision

As collections change over time, the query optimizer deletes the query plan and re-evaluates after any of the following events:

The collection receives 1,000 write operations.
The reIndex rebuilds the index.
You add or drop an index.
The mongod process restarts.
You run a query with explain().

## Cached Query Plan Interface

New in version 2.6.

MongoDB provides Query Plan Cache Methods to view and modify the cached query plans.

## Index Filters

New in version 2.6.

Index filters determine which indexes the optimizer evaluates for a query shape. A query shape consists of a combination of query, sort, and projection specifications. If an index filter exists for a given query shape, the optimizer only considers those indexes specified in the filter.

When an index filter exists for the query shape, MongoDB ignores the hint(). To see whether MongoDB applied an index filter for a query, check the explain.filterSet field of the explain() output.

Index filters only affects which indexes the optimizer evaluates; the optimizer may still select the collection scan as the winning plan for a given query shape.

Index filters exist for the duration of the server process and do not persist after shutdown. MongoDB also provides a command to manually remove filters.

Because index filters overrides the expected behavior of the optimizer as well as the hint() method, use index filters sparingly.

See planCacheListFilters, planCacheClearFilters, and planCacheSetFilter.