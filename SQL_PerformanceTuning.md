## SQL PERFORMANCE TUNING/FINE TUNING
------------------------------------------------------------------------------------------------------------------
1. Server Tuning - Disc: iostat, RAM: vmstat, CPU: top
2. Instance Workload Tuning - Parameter: optimizer setting, Metadata: optimizer statistics tuning, Cursor mgmt: cursor sharing
3. Instancec Object Tuning - Rowpacking, Concurrency, Table row location, caching
4. SQL Tuning - Force changes to exe plan, rewrite sql, sql profiling
	- Remove unnecessary large/full table scans - add b tree indexes; bitmap/function based indexes also can eliminate full table scan.
	- Cache smaller tables - incase of full table scan, ensure that the buffer is available for caching the table. a small table can be cached by forcing it into the KEEP pool.
	- Verify optimal index usage
	- Materialize your aggregations and summaries for static tables

### A strategic plan for Oracle SQL tuning
1. Identify high-impact SQL(use ' v$session_longops' view)
	- Rows processed:  Queries that process a large number of rows will have high I/O and may also have impact on the TEMP tablespace.
	- Buffer gets:  High buffer gets may indicate a resource-intensive query.
	- Disk reads:  High disk reads indicate a query that is causing excessive I/O.
	- Memory KB:  The memory allocation of a SQL statement is useful for identifying statements that are doing in-memory table joins.
	- CPU secs:  This identifies the SQL statements that use the most processor resources.
	- Sorts:  Sorts can be a huge slowdown, especially if theyre being done on a disk in the TEMP tablespace.
	- Executions:  The more frequently executed SQL statements should be tuned first, since they will have the greatest impact on overall performance.
2. Explain Plan (check if there is any full table scan)
	- Create a Plan table to store the results of Explain plan stmt. create ddl is available in samples dir. below are the fields in the explain table,
		- operation:  The type of access being performed. Usually table access, table merge, sort, or index operation
		- options:  Modifiers to the operation, specifying a full table, a range table, or a join
		- object_name:  The name of the table being used by the query component
		- Process ID:  The identifier for the query component
		- Parent_ID:  The parent of the query component. Note that several query components may have the same parent.
3. Self order the table joins

### Case Study:
Lets say we are joining Customer and Order tables.
1. Rewrite the complex subqueries with temp tables & materializations in WITH clause.
2. Use analytic functions to avoid multiple joins or self joins. do multiple aggregations with single pass.
3. if we used not exists, use outer join and IS NULL.
4. Never do calculations on indexed columns unless you have matching function based indexes.
5. Avoid LIKE predicts, use equal operator
6. Never mix data types - if a where clause predicate is numeric, dont use quotes(where custid='1234')
7. use decode or case to perform complex aggregations
8. if a table is smaller, go for a full table scan rather than index based.
