# oracle-change-management-system

\# Oracle Change Management System



A database change and deployment management system built with Oracle APEX, Oracle Database, and PL/SQL.



\## Project Overview



This system organizes database change requests through a controlled workflow: 

\*\*Create → Submit → Review → Approve → Deploy\*\*.



\## Technologies Used



\- Oracle Database

\- PL/SQL

\- Oracle APEX (Release 26.1.3)

\- Git (Version Control)



\## Project Structure



\- `apex/application\_exports/` — APEX application export files (f143972.sql)

\- `database/packages/` — PL/SQL packages (PKG\_CHANGE\_MGMT)

\- `database/tables/` — Table creation scripts

\- `deployment/` — Deployment scripts

\- `design/` — Design documents

\- `documentation/` — Project documentation



\## Setup Instructions



1\. Import the APEX application from `apex/application\_exports/f143972.sql`

2\. Run SQL scripts in `database/` to create tables and packages

3\. Configure the APEX workspace and users

4\. Login with your APEX credentials



\## Testing



Unit tests and functional test cases are documented in `documentation/`. 

The project uses manual functional testing and white-box review of PL/SQL package logic.



\## Branching Model



\- `main` — Stable version

\- `development` — Active development

\- `feature/\*` — Individual features

\- `test/\*` — Testing branches



\## Releases



\- `v0.1-initial-schema` — Initial database schema

\- `v0.2-core-workflow` — Core workflow implemented

\- `v0.3-testing` — Testing completed

\- `v1.0-final` — Final release



\## Author



Yasser Hassan

