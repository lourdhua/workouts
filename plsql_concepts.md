1. **Basic Syntax**
	```
	CREATE OR REPLACE procedure temp
	as
	begin
	 begin
	  insert into ...;
	 EXCEPTION
	 WHEN OTHERS THEN
	  Rollback;
	  return;
	 end;

	 begin
	  update ...;
	 EXCEPTION
	 WHEN OTHERS THEN
	  Rollback;
	  return;
	 end;

	 begin
	  delete ...;
	 EXCEPTION
	 WHEN OTHERS THEN
	  Rollback;
	  return;
	 end;

	 commit;
	end;
	/
	```
2. **Stored Procedure Exception Handling, Transaction Management:**
	```
	create or replace PROCEDURE SPTest
	AS 
	BEGIN 
	  -- We create a savepoint here.
	  SAVEPOINT sp_sptest;

	  insert into emptest(empid,empname,deptno)
	  (1,'ravi',10);

	  insert into test1(id,name,sal)
	  (1,'raju',4444);

	  update emptest set empname='hari' where empid=1;

	-- If any exception occurs
	EXCEPTION
	  WHEN OTHERS THEN
	    ROLLBACK TO sp_sptest;						-- We roll back to the savepoint.
	    RAISE_APPLICATION_ERROR(-20001,SQLERRM); 	-- And of course we raise again, Not raising here is an error!. -20001: user defined error code. SQLERRM - error message.
	END;
	```
3. **PROCEDURE TO RETURN RESUTLSET:**
	 - procedure will return resultset through refcursor variable.
	 - we need to create a generic package with cursor variable and use it as out parameter in the procedure.
	```
		CREATE OR REPLACE PACKAGE TYPES
		AS
			TYPE cursorType IS REF CURSOR;
		END;

	--Procedure:
		CREATE OR REPLACE PROCEDURE SP_GETTOTALSTRINGS(totalStrings OUT TYPES.cursorType) AS 
		BEGIN
		  OPEN totalStrings FOR
			SELECT OPERATORS_NAME, REGION, FIELD_NAME, WELL_TYPE, COUNT(STRING) AS STR_COUNT
			FROM IWMRS_WELL_HEADER@PURIWMRS
			GROUP BY OPERATORS_NAME, REGION, FIELD_NAME, WELL_TYPE;
		END SP_GETTOTALSTRINGS;

	--To verify:
		variable results REFCURSOR;
		EXEC SP_GETTOTALSTRINGS(:results);
		PRINT results;
	```
4. **Scheduling a stored procedure:**
 - **We need to create a job.**
	```
	--Create a Job
	begin
	dbms_scheduler.create_job (
	   job_name           =>  '[]JobName]',
	   job_type           =>  'STORED_PROCEDURE',
	   job_action         =>  '[SP_NAME]',
	   start_date         =>  '[date for job start]',			//[10-NOV-2015 06:56:00 PM]
	   repeat_interval    =>  'SYSDATE+2/1440',					// currently set for every two mins
	   enabled            =>  TRUE);							//
	END;

	-- To disable a job:
		begin
		dbms_scheduler.disable ('JobName');
		end;
	```
5. **Scheduler Status:**
	```
	select * from dba_scheduler_job_run_details where job_name = 'GATHER_STATS_JOB' order by log_id desc	-- to get the job run/execution details
	select * from dba_scheduler_jobs -- to get the job details
	select * from dba_schedular_schedules -- to get the scheduler information
	```
6. **Passing Date to stored procedure/ calling proc/ executing proc**
	```
	declare
	v_date DATE := sysdate;
	  begin
	    SPROC_SSM_ALL(v_date);
	  end;
	```
7. **[plsql debugging](http://www.thatjeffsmith.com/archive/2014/02/how-to-start-the-plsql-debugger/)**
8. **What is Pragma Autonomous_transaction in Oracle?**
	- The AUTONOMOUS_TRANSACTION pragma changes the way a subprogram works within a transaction. 
	- A subprogram marked with this pragma can do SQL operations and commit or roll back those operations, 
	- without committing or rolling back the data in the main transaction. 
	- Pragmas are processed at compile time, not at run time.
