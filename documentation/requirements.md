Functional Requirements

The system shall:

•	FR1: Allow authorized users to log into the system.

•	FR2: Allow requesters to create database change requests.

•	FR3: Generate a unique identifier for every change request.

•	FR4: Allow users to attach or enter SQL/PLSQL deployment scripts.

•	FR5: Support normal and emergency change requests.

•	FR6: Route submitted changes to the appropriate reviewer.

•	FR7: Prevent unauthorized users from approving changes.

•	FR8: Prevent requesters from approving their own changes.

•	FR9: Record approval and rejection decisions.

•	FR10: Validate change requests before deployment.

•	FR11: Allow authorized administrators to execute approved changes.

•	FR12: Record deployment results and errors.

•	FR13: Support rollback or recovery procedures for failed deployments.

•	FR14: Record audit information for important user and system actions.

•	FR15: Provide dashboards and reports for change status and history.

•	FR16: Allow administrators to manage users, roles, and system settings.

Non-Functional Requirements

Security

The system should enforce authentication, authorization, least privilege, segregation of duties, and audit logging. Oracle APEX provides authorization schemes and access controls that can support these requirements (Oracle, 2026c).

Performance

Normal pages and dashboards should respond within approximately 3 seconds under the expected capstone workload. Deployment execution time will depend on the database operation, so the system should display execution status rather than imposing an unrealistic fixed duration.

Reliability

The system should maintain transaction consistency and record successful and failed deployment attempts. Failed operations should produce useful error information.

Usability

The interface should provide clear forms, status indicators, approval actions, error messages, and dashboards so users can understand the current state of each change.

Scalability

The database design should use normalized tables and modular PL/SQL packages so that additional change types, roles, environments, and reports can be added later.

Maintainability

Business rules should be implemented in organized PL/SQL packages instead of being duplicated across many APEX pages. This supports modular development and easier maintenance (Oracle, 2026b).

Design Rationale

The architecture separates presentation, workflow, business logic, data, and auditing responsibilities. This separation reduces unnecessary coupling and makes the system easier to maintain. Software architecture should connect system requirements with appropriate design decisions rather than treating architecture as an isolated technical activity (Walker, 2022).

Using Oracle APEX is appropriate because the platform operates with Oracle Database and supports application lifecycle practices, including application export/import and source control (Oracle, 2026a; Oracle, 2026e). PL/SQL provides the business-logic layer needed to enforce change-management rules close to the database.



