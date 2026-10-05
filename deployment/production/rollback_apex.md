\# APEX Application Rollback



This document describes how to remove the APEX application from the environment.



\*\*Note:\*\* This removes ONLY the APEX application. The database objects (tables, packages) are removed separately using `rollback.sql`.



\## Option 1: APEX App Builder (Recommended)



1\. Open Oracle APEX → \*\*App Builder\*\*

2\. Find the application \*\*Oracle Change Management System\*\* (ID: 143972)

3\. Click the \*\*three dots\*\* menu → \*\*Delete\*\*

4\. Confirm deletion

5\. Empty the application's \*\*recycle bin\*\* to free space



\## Option 2: SQL\*Plus (Command Line)



Run the following in SQL\*Plus as the schema owner:



```sql

BEGIN

&#x20;   APEX\_APPLICATION\_INSTALL.DROP\_APPLICATION(

&#x20;       p\_application\_id => 143972

&#x20;   );

END;

/

