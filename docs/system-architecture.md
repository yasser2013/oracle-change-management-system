1\. System Architecture Blueprint and Module Design

Introduction

The proposed capstone project is an Oracle Database Change and Deployment Management System designed to improve the way database changes are requested, reviewed, approved, tested, deployed, and audited. Database changes can create security, availability, and data-integrity risks when they are executed without appropriate authorization or documentation. NIST describes configuration change control as a systematic process that includes requesting, evaluating, testing, reviewing, approving, implementing, and documenting changes (Johnson et al., 2019). Therefore, the proposed system will provide a centralized workflow for managing database changes from initial request through final deployment.

The system will be developed using Oracle Database as the data layer, PL/SQL for business logic and workflow processing, and Oracle APEX as the web-based user interface. Oracle APEX provides direct access to Oracle Database and supports secure and scalable application development (Oracle, 2026a). PL/SQL packages will be used to organize related procedures and functions because Oracle identifies packages as a way to group logically related program units and control their use (Oracle, 2026b).

System Architecture

The proposed architecture consists of five major layers: the user interface, application/workflow layer, database business-logic layer, data layer, and audit/security layer.

The APEX interface will provide forms, dashboards, approval pages, deployment pages, and reports. The workflow layer will enforce the sequence of activities. PL/SQL packages will implement business rules such as creating requests, validating required fields, changing request status, recording approvals, and initiating deployment. Oracle supports PL/SQL procedures and packages as core building blocks for database applications (Oracle, 2026b).

Module-Wise Functional Design

User and Role Management Module

Input: Username, password/authentication information, role, and user status.

Output: Authenticated user session and authorized application functions.

Methodology: Role-based access control and least privilege.

The main roles will be requester, reviewer, approver, deployment administrator, and system administrator. A requester can create and track a change but cannot approve or deploy the same change. A reviewer evaluates the technical details, while an authorized approver determines whether the change can proceed. Oracle APEX provides authentication and authorization mechanisms for controlling access to applications, pages, and components (Oracle, 2026c).

Change Request Module

Input: Change title, description, reason, change type, priority, affected database/object, proposed implementation date, SQL/PLSQL script, risk, and rollback plan.

Output: Unique change-request ID and initial status.

Methodology: Structured request validation and controlled workflow.

The system will require mandatory information before a request can be submitted. Change types will include normal, standard, and emergency changes.

Review and Approval Module

Input: Submitted change request and supporting information.

Output: Review comments, approval/rejection decision, and updated workflow status.

Methodology: Segregation of duties and multi-stage approval.

The system will prevent a requester from approving their own change. This separation supports accountability and reduces the risk of unauthorized modifications. Configuration change control should clearly identify responsibilities and authorities for each stage of the process (Johnson et al., 2019).

Script Validation and Testing Module

Input: SQL/PLSQL deployment script and target database information.

Output: Validation result, test result, errors/warnings, and test evidence.

Methodology: Syntax validation, controlled testing, dependency checking, and risk assessment.

The module will identify whether required information is present and whether the script passes defined validation checks before deployment. High-risk changes should require additional testing and approval.

Deployment Module

Input: Approved change request and validated deployment script.

Output: Deployment status, execution result, execution time, and error information.

Methodology: Controlled execution through PL/SQL procedures and restricted deployment privileges.

Only authorized deployment personnel will execute approved changes. Oracle recommends considering application and database roles and using appropriate privileges when designing secure database applications (Oracle, 2026d).

Rollback and Recovery Module

Input: Failed deployment, rollback script, backup/recovery information, or administrator decision.

Output: Rollback result and updated deployment status.

Methodology: Predefined rollback procedures and documented recovery actions.

The module will support failed deployments by recording the failure and providing a controlled rollback process where technically possible.

Audit and Reporting Module

Input: User activities, request changes, approvals, deployments, and errors.

Output: Audit reports, change history, deployment history, and security reports.

Methodology: Immutable-style audit records and timestamped event logging.

The audit module is important because it allows administrators to determine who performed an action, when it occurred, and what happened during the change process.



