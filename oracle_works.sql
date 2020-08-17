# Oracle sql commands
1. sqlplus connection string
		```
		sqlplus username/password@host:port/service
		sqlplus x/y@c:a/b
		sqlplus x/y@SID
		```
2. To show the current logged in user name:
		`SHOW user;`
3. To get the currently connected instance details (user schema must be having admin rights to view oracle parameters):
		`SHOW PARAMETER instance_name -- also we can use SHOW PARAMETER to view all parameter values`
4. Create Public database link (DB link is used to create access to remote schema objects. either to another database or to another schema objects)
	**PRIVATE:** Creates link in a specific schema of the local database. Only the owner of a private database link or PL/SQL subprograms in the schema can use this link.
	**PUBLIC:** Creates a database-wide link. All users and PL/SQL subprograms in the database can use the link to access database objects in the corresponding remote database.
	**GLOBAL:** Creates a network-wide link. When an Oracle network uses a directory server, the directory server automatically create and manages global database links for every Oracle Database in the network. Users and PL/SQL subprograms in any database can use a global link to access objects in the corresponding remote database.
	*using TNS link*
		```
		create public database link mylinkname
		connect to remote_username identified by remoteuserpass
		using 'TNSNAME_OF_REMOTE';
		```
	*without TNS link*
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
	*Full database level:*
		```
			exp userid/password@tnsname file=path.dmp log=log.dmp full=y buffer=10485867 statistics=none
		```
	*Schema level:*
		```
			exp userid/password@tnsname file=path.dmp log=log.dmp buffer=10485867 statistics=none owner=schemaname
		```
	*Table level:*
		```
			exp userid/password@tnsname file=path.dmp log=log.dmp buffer=10485867 statistics=none tables='schemaname.tablename','schemaname.tablename'
		```
8. Import syntax
		```imp scott/tiger@example file=<file>.dmp fromuser=<source> touser=<dest>```
9. Execute sql script/dump file through 
	* sql plus:
		```sqlplus user/password@server @script.sql```
	* GUI tool (login to the destination schema)
		```./sqlfile.sql```
10. DDL
10.1. Tables:
		```
		Create table: CREATE TABLE TABLENAME( ID INT NOT NULL, NAME VARCHAR2(10))
		Add Column: ALTER TABLE TABLENAME ADD ( [COLNAME] [DATATYPE]);
		Modify Column: ALTER TABLE TABLENAME MODIFY ( [COLNAME] [NEWDATATYPE]);
		Drop Column: ALTER TABLE TABLENAME DROP ([COLNAME]);
		```
10.2. Constraints:
		```
		Add Unique constraint: ALTER TABLE [table name] ADD CONSTRAINT [constraint name] UNIQUE( [column name] ) USING INDEX [index name];
		Drop Unique constraint: ALTER TABLE [table name] DROP CONSTRAINT [constraint name];
		```
10.3. Indexes:
		```
		Normal: Whenever we create a PK column, oracle implicitly creates normal index.
		Function Based:	Indexes are saved on functional basis. Ex: UPPER(col)
		Bitmap: A type of index that uses a string of bits to quickly locate rows in a table.Bitmap indexes are normally used to index low cardinality columns in a warehouse environment.
		B-tree: A type of index that uses a balanced tree structure for efficient record retrieval. B-tree indexes store key data in ascending or descending order; especially for OLTP.
		```
11. Get the (Database Object)table created date:
		```select created from user_objects where object_name = 'TABLENAME_IN_CAPS';```
12. Get the Max length of data from a field/column:
		```Select max(length(your_col_name)) as max_length From your_table_name;```
13. Creating Simple Date Dimension (Add additional columns as needed):
		```
			select to_date(to_char(19000101), 'yyyymmdd') + lvl dateval, lvl numeric_id
			from (    
				select 0 lvl from dual
			union all
				select level lvl
				from dual
				connect by level <= 74000)
			where to_date(to_char(19000101), 'yyyymmdd') + lvl<='31-DEC-2100';
		```
14. MINUS OPERATOR: MINUS operator (in oracle) is used to subtract the rows which are available in the second result, from the first result set.
15. COALESCE VS NVL
	* COALESCE - MODERN FUNCTION; ANSI STD; EVALUATES THE FIRST ARGUMENT AND IF IT FAILS, MOVE TO THE NEXT ONE. DT of all args should be same. takes any no.of args.
	* NVL - OLDER ORACLE SPECIFIC; SLOWER; ALWAYS EVALUATES BOTH ARGUMENT. DT of both args should be same(only two args).
	* NVL2 - same as NVL but this accepts three parameters.
		both functions will return null, if all the args are null.




