# Basic to Advanced String Manipulation Functions in Oracle
Reference: [SQL Cheatsheet](https://en.wikibooks.org/wiki/Oracle_Programming/SQL_Cheatsheet)
* **Instr:** Instr returns an integer that specifies the location of a sub-string within a string. 
```
syntax: instr( string1, string2, [ start_position ], [ nth_appearance ] )
Example: select instr('this is the mass response','s',5,2) from dual; --returns 15
```
* **Replace:** Replace looks through a string, replacing one string with another.
```
Example: replace('i am here','am','am not');	--this returns "i am not here"
```
* **Substr:** Substr returns a portion of the given string. The "start_position" is 1-based, not 0-based. If "start_position" is negative, substr counts from the end of the string.
```	
Example: SELECT substr( 'oracle pl/sql cheatsheet', 8, 6) FROM dual;  --returns "pl/sql" since the "p" in "pl/sql" is in the 8th position in the string (counting from 1).
```
* **Length:** returns an integer representing the length of a given string
```
SELECT length('hello world') FROM dual;	--this returns 11, since the argument is made up of 11 characters including the space
```
* **Trim:** used to filter unwanted characters from strings. By default they remove spaces, but a character set can be specified for removal as well.
```
trim ( [ leading | trailing | both ] [ trim-char ] from string-to-be-trimmed );
trim ('   removing spaces at both sides     ');
this returns "removing spaces at both sides"

ltrim ( string-to-be-trimmed [, trimming-char-set ] );
ltrim ('   removing spaces at the left side     ');
this returns "removing spaces at the left side     "

rtrim ( string-to-be-trimmed [, trimming-char-set ] );
rtrim ('   removing spaces at the right side     ');
this returns "   removing spaces at the right side"
```
* **Printing pyramids of stars:**
```
SELECT RPAD('*',LEVEL*1,'*') FROM DUAL CONNECT BY LEVEL<=5;	--RPAD('originalstring',[len],'stringtoappend') APPENDS [stringtoappend] after [originalstring] if [len] is available

SELECT RPAD('*',LEVEL*1,'*') FROM DUAL CONNECT BY LEVEL<=5	-- pyramid
UNION ALL 
SELECT RPAD('*',(5-LEVEL)*1,'*') FROM DUAL CONNECT BY LEVEL<=5;
```
* **[String Aggregation](http://www.oracle-base.com/articles/misc/string-aggregation-techniques.php)**
  * **GROUP CONCATE**
  ```
  select <GROUP_ID_COLUMN>, regexp_replace(listagg(<GROUPED_COLUMN>,',') within group(order by <GROUPED_COLUMN>),'([^,]+)(,\1)*(,|$)', '\1\3')
  from DUAL
  group by <GROUP_ID_COLUMN>
  ;
  ```
* **CONCAT(‘A’,’BC’)** Concatenate two strings and return the combined string.
* **INITCAP(‘hi  there’)** Converts the first character in each word in a specified string to uppercase and the rest to lowercase.
