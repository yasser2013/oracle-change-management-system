\# APEX Application Deployment



The APEX application is deployed separately from the database objects, using the APEX App Builder web interface.



\## Prerequisites

\- Oracle APEX 26.1 or later

\- Access to APEX App Builder

\- Database objects already deployed (run `deploy.sql` first)



\## Import Steps



1\. Open Oracle APEX → \*\*App Builder\*\*

2\. Click \*\*Import\*\* (top-right)

3\. Select \*\*Import Application\*\*

4\. Upload: `../apex/application\_exports/f143972.sql`

5\. Follow the wizard:

&#x20;  - \*\*Application ID:\*\* keep 143972 or let APEX assign a new one

&#x20;  - \*\*Parsing Schema:\*\* select your target schema

&#x20;  - \*\*Build Status:\*\* Run and Build Application

6\. Click \*\*Install\*\*

7\. Wait for the installation to complete

8\. Click \*\*Run Application\*\*



\## Post-Import Configuration



1\. \*\*Authentication Scheme:\*\*

&#x20;  - Verify `User Table Authentication` is set

&#x20;  - Confirm `FN\_APEX\_AUTHENTICATE` function exists in the DB



2\. \*\*Users:\*\*

&#x20;  - Insert at least one user in the `USERS` table

&#x20;  - Assign roles via `USER\_ROLES`



3\. \*\*Test:\*\*

&#x20;  - Login with a valid user

&#x20;  - Verify the workflow: Create → Submit → Review → Approve

