# Atomicity and Transactions

In MongoDB, a write operation is atomic on the level of a single document, even if the operation modifies multiple embedded documents within a single document.

When a single write operation modifies multiple documents, the modification of each document is atomic, but the operation as a whole is not atomic and other operations may interleave. However, you can isolate a single write operation that affects multiple documents using the $isolated operator.

## $isolated Operator

Using the $isolated operator, a write operation that affect multiple documents can prevent other processes from interleaving once the write operation modifies the first document. This ensures that no client sees the changes until the write operation completes or errors out.

Isolated write operation does not provide “all-or-nothing” atomicity. That is, an error during the write operation does not roll back all its changes that preceded the error.

The $isolated does not work on sharded clusters.

For an example of an update operation that uses the $isolated operator, see $isolated. For an example of a remove operation that uses the $isolated operator, see Isolate Remove Operations.

## Transaction-Like Semantics

Since a single document can contain multiple embedded documents, single-document atomicity is sufficient for many practical use cases. For cases where a sequence of write operations must operate as if in a single transaction, you can implement a two-phase commit in your application.

However, two-phase commits can only offer transaction-like semantics. Using two-phase commit ensures data consistency, but it is possible for applications to return intermediate data during the two-phase commit or rollback.

For more information on two-phase commit and rollback, see Perform Two Phase Commits.

## Concurrency Control

Concurrency control allows multiple applications to run concurrently without causing data inconsistency or conflicts.

An approach may be to create a unique index on a field (or fields) that should have only unique values (or unique combination of values) prevents duplicate insertions or updates that result in duplicate values. For examples of use cases, see update() and Unique Index and findAndModify() and Unique Index.

Another approach is to specify the expected current value of a field in the query predicate for the write operations. For an example, see Update if Current.

The two-phase commit pattern provides a variation where the query predicate includes the application identifier as well as the expected state of the data in the write operation.