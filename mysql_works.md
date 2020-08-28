**Mysql Version details:**
* MySQL 5.0: included it and turned it on by default. Documentation of some of the short-comings appears in "MySQL Federated Tables: The Missing Manual".
* MySQL 5.1: production release 27 November 2008 (event scheduler, partitioning, plugin API, row-based replication, server log tables)
* MySQL 5.1 and 6.0-alpha showed poor performance when used for data warehousing – partly due to its inability to utilize multiple CPU cores for processing a single query.
* MySQL 5.5 was generally available (as of December 2010). Enhancements and features include:
  * The default storage engine is InnoDB, which supports transactions and referential integrity constraints.
  * Improved InnoDB I/O subsystem; Improved SMP support
  * Semisynchronous replication.
  * SIGNAL and RESIGNAL statement in compliance with the SQL standard.
  * Support for supplementary Unicode character sets utf16, utf32, and utf8mb4.
  * New options for user-defined partitioning.
* MySQL 5.6:
  * higher transactional throughput in InnoDB, new NoSQL-style memcached APIs, improvements to partitioning for querying and managing very large tables, TIMESTAMP column type that correctly stores milliseconds, improvements to replication, and better performance monitoring.

**Show Status vs Show Global Status**
  * Show Status - Gives you status variables that have updated within your session. command can also be expressed as SHOW SESSION STATUS
	* Show Global Status - Gives you status variables that have updated since Mysqld Started for all sessions that are connected to.
	* To physically show the difference, the information_schema database has them separated as
		```
		INFORMATION_SCHEMA.GLOBAL_STATUS
		INFORMATION_SCHEMA.SESSION_STATUS
		
		SELECT a.variable_name,a.variable_value,b.variable_value
		FROM information_schema.global_status A INNER join information_schema.session_status B
		USING (variable_name) WHERE A.variable_value <> B.variable_value;
		```
