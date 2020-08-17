# Oracle sql commands
1. sqlplus connection string
```
sqlplus username/password@host:port/service
sqlplus username/password@SID	--if you already have the TNS name configured
```
2. To show the current logged in user name:
```
SHOW user;
```
3. To get the currently connected instance details (user schema must be having admin rights to view oracle parameters):
```
SHOW PARAMETER instance_name -- also we can use SHOW PARAMETER to view all parameter values
```
4. Create Public database link (DB link is used to create access to remote schema objects. either to another database or to another schema objects)
* **PRIVATE:** Creates link in a specific schema of the local database. Only the owner of a private database link or PL/SQL subprograms in the schema can use this link.
* **PUBLIC:** Creates a database-wide link. All users and PL/SQL subprograms in the database can use the link to access database objects in the corresponding remote database.
* **GLOBAL:** Creates a network-wide link. When an Oracle network uses a directory server, the directory server automatically create and manages global database links for every Oracle Database in the network. Users and PL/SQL subprograms in any database can use a global link to access objects in the corresponding remote database.
* *using TNS link*
	```
	create public database link mylinkname
	connect to remote_username identified by remoteuserpass
	using 'TNSNAME_OF_REMOTE';
	```
* *without TNS link*
	```
	create public database link mylinkname
		connect to remote_username identified by remoteuserpass
		using '(DESCRIPTION =
		(ADDRESS = (PROTOCOL = TCP)(HOST = remoteservername)(PORT = remoteserverport))
		(CONNECT_DATA =
		  (SID = remoteSID)
		)
	  )';
	```
5. Drop database link
```
DROP DATABASE LINK DBLINKNAME;
DROP PUBLIC DATABASE LINK DBLINKNAME;
```
6. List all database links
```
select * from DBA_DB_LINKS -- All DB links defined in the database
select * from ALL_DB_LINKS -- All DB links the current user has access to
select * from USER_DB_LINKS -- All DB links owned by current user
```
7. Import and Export Database objects( export/import are command promp utilities and not supported by sqlplus)
* **Full database level:**
	```
	exp userid/password@tnsname file=path.dmp log=log.dmp full=y buffer=10485867 statistics=none
	```
* **Schema level:**
	```
	exp userid/password@tnsname file=path.dmp log=log.dmp buffer=10485867 statistics=none owner=schemaname
	```
* **Table level:**
	```
	exp userid/password@tnsname file=path.dmp log=log.dmp buffer=10485867 statistics=none tables='schemaname.tablename','schemaname.tablename'
	```
8. Import syntax
```
imp scott/tiger@example file=<file>.dmp fromuser=<source> touser=<dest>
```
9. Execute sql script/dump file through 
* **sql plus:**
	```
	sqlplus user/password@server @script.sql
	```
* **GUI tool (login to the destination schema)**
	```
	./sqlfile.sql
	```
10. DDL
	- 10.1. Tables:
		- **Create table:** `CREATE TABLE TABLENAME( ID INT NOT NULL, NAME VARCHAR2(10));`
		- **Add Column:** `ALTER TABLE TABLENAME ADD ( [COLNAME] [DATATYPE]);`
		- **Modify Column:** `ALTER TABLE TABLENAME MODIFY ( [COLNAME] [NEWDATATYPE]);`
		- **Drop Column:** `ALTER TABLE TABLENAME DROP ([COLNAME]);`
	- 10.2. Constraints:
		- **Add Unique constraint:** `ALTER TABLE [table name] ADD CONSTRAINT [constraint name] UNIQUE( [column name] ) USING INDEX [index name];`
		- **Drop Unique constraint:** `ALTER TABLE [table name] DROP CONSTRAINT [constraint name];`
	- 10.3. Indexes:
		- **Normal:** Whenever we create a PK column, oracle implicitly creates normal index.
		- **Function Based:** Indexes are saved on functional basis. Ex: UPPER(col)
			```
			CREATE INDEX [INDEX_NAME]
			ON [TABLE_NAME]( CASE WHEN COL1 IS NOT NULL THEN [COL1/COL2] END,
			CASE WHEN [COL2] IS NOT NULL THEN [COL2] END, ...
			[COL3] END)
			```
		- **Bitmap:** A type of index that uses a string of bits to quickly locate rows in a table.Bitmap indexes are normally used to index low cardinality columns in a warehouse environment.
		- **[B-tree](https://www.youtube.com/watch?v=Ji6NVCb-td8&list=PLUeF6A_iPYw2p2EIazFT8rcKPOFsOwGNs):** A type of index that uses a balanced tree structure for efficient record retrieval. B-tree indexes store key data in ascending or descending order; especially for OLTP.
11. Get the (Database Object)table created date:
```
select created from user_objects where object_name = 'TABLENAME_IN_CAPS';
```
12. Get the Max length of data from a field/column:
```
Select max(length(your_col_name)) as max_length From your_table_name;
```
13. Alter password expiration date/set to never expire - Insecure option, using for the context only:
```
--login to SYS, To alter the password expiry policy for a certain user profile in Oracle first check wich profile the user is in.
ALTER USER <SCHEMANAME> ACCOUNT UNLOCK;
ALTER USER <SCHEMANAME> IDENTIFIED BY <PASSWORD>;
alter profile DEFAULT limit PASSWORD_REUSE_TIME unlimited;
alter profile DEFAULT limit PASSWORD_LIFE_TIME  unlimited;
select username, account_status, EXPIRY_DATE from dba_users where username='<SCHEMANAME>';
```
14. MINUS OPERATOR: MINUS operator (in oracle) is used to subtract the rows which are available in the second result, from the first result set.
15. COALESCE VS NVL
	* **COALESCE** - ANSI Standard; Modern function that takes any number of arguments; evaluates the first argument and if it fails, move to the next one. Datatype of all arguments must be same.
	* **NVL** - Oracle specific; Slower as it always evaluate both arguments. Datatype of both arguments must be same(only takes two arguments).
	* **NVL2** - same as NVL but this accepts three arguments.
	  * both NVL & NVL2 will return null, if all the arguments are null.
16. Extracting META data from Oracle (INFORMATION_SCHEMA)
* **List TABLEs** `SELECT table_name FROM user_tables;`
* **List VIEWs** `SELECT view_name FROM user_views;`
* **List users** `SELECT username FROM dba_users;`
* **List table fields** `SELECT column_name FROM user_tab_columns;`
* **Reference:** [extracting meta data](http://www.alberton.info/oracle_meta_info.html#.Vs2jb-a3NZ9)
17. UNION VS MINUS VS INTERSECT:
```
SELECT 3 FROM DUAL		// this is implicitly converted to 'TO_BINARY_FLOAT(3)' and is a valid sql
   INTERSECT
SELECT 3f FROM DUAL;

SELECT '3' FROM DUAL		// results error as '3' couldnt be converted to float
   INTERSECT
SELECT 3f FROM DUAL;
```
18. [Adding tnsnames in sql developer:](http://stackoverflow.com/questions/425029/oracle-tns-names-not-showing-when-adding-new-connection-to-sql-developer/425104#425104)
19. Get the (Database Object)table created date
```
select created from user_objects where object_name = 'TABLENAME_IN_CAPS';
```
20. Get the Max length of data from a field/column:
```
Select max(length(your_col_name)) as max_length From your_table_name;
```
21. Check oracle version
```
Select * from v$version;
```
22. Oracle list process & kill long running process:
	22.1. To check the processlist:
	```
	select s.sid, s.serial#, p.spid, s.username, s.schemaname, s.program, s.terminal, s.osuser
	from v$session s
	join v$process p on s.paddr = p.addr
	where s.type != 'BACKGROUND';
		 
	select  object_name,   object_type,   session_id, 
	type,         -- Type or system/user lock
	lmode,        -- lock mode in which session holds lock
	request,   block,   ctime         -- Time since current mode was granted
	from v$locked_object, all_objects, v$lock
	where v$locked_object.object_id = all_objects.object_id AND   v$lock.id1 = all_objects.object_id AND   v$lock.sid = v$locked_object.session_id
	order by session_id, ctime desc, object_name
	```
	22.2. To Kill:
	```
	alter system kill session 'sid,serial#';
	```
	Reference: 
	[show processes](http://stackoverflow.com/questions/199508/how-do-i-show-running-processes-in-oracle-db), 
	[kill process](http://stackoverflow.com/questions/9545560/how-to-kill-a-running-select-statement)	
23. [Oracle function returns a table](https://www.linkedin.com/pulse/pipelined-table-functions-faster-data-fetching-etl-gunathilaka/):
* create a package
* create a TYPE typeRec for table record (similar to rowtype variable)
* create a TYPE mytable is TABLE of typeRec
* Create the function body return mytable pipelined
24. Synonyms
* **Private synonym:** `CREATE SYNONYM [SYN_NAME] FOR [SCHEMA.OBJ_NAME];`
	* Creates a synonym within the schema and can be accessed within it/by the grantees.
	* Shares same tablespace as tables & views. 
* **Public synonym:** `CREATE PUBLIC SYNONYM [SYN_NAME] FOR [SCHEMA.OBJ_NAME];`
	* Creates a public synonym in current schema and can be accessed by every schema in the DB.
	* Doesn't shares same tablespace as tables & views. It is stored in common tablespace.
	* Public synonyms have security & performance issues; if two applications from different schema try to have same named synonym it will fail.
25. SID vs Global DB Name:
* **SID (System Identifier):** A SID (almost) uniquely identifies an instance.  Actually, $ORACLE_HOME, $ORACLE_SID and $HOSTNAME identify an instance uniquely. The SID is 64 characters, or less; at least on Oracle 9i. The system identifier is included in the CONNECT_DATA parts of the connect descriptors in a tnsnames.ora file. The SID defaults to the database name.
* **Global Database Name:** A database is uniquely identified by a global database name. Usually, a global database name has the form somename.domain. The global database name is the composit of db_domain and db_name. 

26. GETTING DB SIZE:
```
dba_data_files = dba_segments + dba_free_space + Oracle overhead (header, bitmap...) 
select sum(bytes/1024/1024/1024) "Size in GB" from dba_data_files;
select sum(bytes/1024/1024/1024) "Size in GB" from DBA_segments; 
select sum(bytes/1024/1024/1024) from dba_extents;
```
27. [Access data from another db server(SQL SERVER)](http://www.dba-oracle.com/t_heterogeneous_database_connections_sql_server.htm)
28. [Application Contexts](http://www.dba-oracle.com/plsql/t_plsql_contexts.htm): to set name-value pairs for a session/globally.
29. [Listener parameters](http://psoug.org/reference/listener.html) and samples
* Listener is a process that resides on the server whose responsibility is to listen for incoming client connection requests and manage the traffic to the server.
* [Configuring Listener](http://www.dummies.com/how-to/content/how-to-configure-the-database-listener-with-listen.html)
30. Sub queries:
* **Correlated:** You reference a column from main query in the subquery. For each row processed in the main query, the correlated subquery is evaluated once.
* **Non-Correlated:** The inner sql executed first and then the result passed to main sql.
* **Inline Views:** A subquery that appears in the from clause of a sql is called inline view.
31. [Update with Joins](https://community.oracle.com/thread/401752)
32. oracle variable passing & verifying sql - There are two types of variable in SQL-plus.
* **substitution** (substitution variables can replace SQL*Plus command options or other hard-coded text)
```
define a = 1;
select &a from dual;
undefine a;
```
* **bind** (bind variables store data values for SQL and PL/SQL statements executed in the RDBMS; they can hold single values or complete result sets)
```
var x number;
exec :x := 10;
select :x from dual;
exec select count(*) into :x from dual;
exec print x;
```
