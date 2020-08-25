## Oracle DB overview:
### Physical Structure:
1. Data Files: 
   - Oracle DB data is stored in data files physically.
   - Each DB is associated with one or more data files and one or more data files are associated with separate tables spaces.
   - If a data file is full, its extended automatically.
   - Initially data is read from data file and kept in memory cache to reduce the disk access.
2. Control Files:
   - Only one control file available for a DB. it is a root file that tracks the physical components of the database.
   - It contains DB specific details like, DB name, created date, data file locations etc.
   - When an oracle instance started, the control file will load all the data files, redo log files  associated with the DB instance.
	
### Logical Structure:
1. Data blocks: 	Finest grain level of logical storage. which is usually a disk block of 2KB size.
2. Extents:		Specific number of contiguous data blocks.
3. Segments:		set of extents allocated for a table, index, transaction operation, session.
4. Tablespaces:	Logical grouping of related blocks, extents and segments.  A tablespace contains one or more data files. for every DB two default system tablespaces will be created - SYS, SYSAUX. other than these we have USERS tablespace. Its used for assigning quota to a user.
   - The SYSTEM tablespace includes the following information, all owned by the SYS user:
      - The data dictionary
      - Tables and views that contain administrative information about the database		
      - Compiled stored objects such as triggers, procedures, and packages
   - Tablespace Modes:
      - Read/Write Mode: 	even SYS and SYSAUX also in read/write mode only.
      - Read only: 			user defined only readable tablespaces.
      - online/offline:		if a tablespace is offline, the DB wont allow any DML on the references to the tablespace.
				
### Schema Objects:
1. Partitions - Decomposing very large tables, indexes into smaller pieces is called partitioning.
2. views 
   - Updatable joined views: involves two or more base tables in a view.
   - Object view:			Contains object table as base tables.
   - Materialized view:		
3. Sequences - Using a sequence generator.
4. Dimensions - Attribute tables that contain Business object information.
5. Synonyms - synonym is just an alias of an object. we can''t create multiple public synonyms with same name. they are also not secure because when we create obj. privileges for a synonym, we are exactly creating it to the underlying object itself and exposing it.

### Data dictionary:
1. which is a read-only set of tables that provides administrative metadata about the database. A data dictionary contains information such as
   - The definitions of every schema object in the database, including default values for columns and integrity constraint information
   - The amount of space allocated for and currently used by the schema objects
   - The names of Oracle Database users, privileges and roles granted to users, and auditing information related to users
   - DBA_ views - shows all relevant info from the DB. these are intended only for admin.
   - ALL_ views - shows info abt objects owned by a user and accessible to a user.
   - USER_ views - shows info abt objects owned by a user.
			
### Privileges and Roles:
1. System Priv - given to a user by an admin user or by a user who has right to grant system privileges. ability to perform particular action in DB. 
   - view to list sys privileges SYSTEM_PRIVILEGE_MAP. 
   - SYNTAX: GRANT/REVOKE SYSPRIV1, SYSPRIV2, ... TO USER1, USER2, ....
2. Object Priv - Specific to an obj. of DB and is given by the owner of a DB. 
   - view list of obj privileges 'USER_TAB_PRIVS'
   - syntax: GRANT/REVOKE OBJPRIV1, OBJPRIV2, ... ON OBJNAME TO USER1, USER2...
