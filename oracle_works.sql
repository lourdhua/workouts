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
