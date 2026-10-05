-- 1. إدخال الأدوار
INSERT INTO roles (role_name, description) VALUES ('Requester', 'Creates change requests');
INSERT INTO roles (role_name, description) VALUES ('Reviewer', 'Reviews change requests');
INSERT INTO roles (role_name, description) VALUES ('Approver', 'Approves or rejects changes');
INSERT INTO roles (role_name, description) VALUES ('Deployment Admin', 'Deploys approved changes');
INSERT INTO roles (role_name, description) VALUES ('System Admin', 'Manages system settings');

-- 2. إدخال البيئات
INSERT INTO environments (environment_name, description) VALUES ('Development', 'Development environment');
INSERT INTO environments (environment_name, description) VALUES ('Testing', 'Testing environment');
INSERT INTO environments (environment_name, description) VALUES ('Production', 'Production environment');

-- 3. إدخال المستخدمين
INSERT INTO users (username, password_hash, full_name, email, status) 
VALUES ('yasser', 'hash123', 'Yasser Hassan', 'yasser@test.com', 'Active');

INSERT INTO users (username, password_hash, full_name, email, status) 
VALUES ('reviewer1', 'hash123', 'Ahmed Ali', 'ahmed@test.com', 'Active');

INSERT INTO users (username, password_hash, full_name, email, status) 
VALUES ('approver1', 'hash123', 'Sara Mohamed', 'sara@test.com', 'Active');

INSERT INTO users (
    username,
    password_hash,
    full_name,
    email,
    status
)
VALUES (
    'deployadmin',
    'hash123',
    'Deployment Admin',
    'deploy@test.com',
    'Active'
);
INSERT INTO users (
    username,
    password_hash,
    full_name,
    email,
    status
)
VALUES (
    'admin',
    'hash123',
    'System Administrator',
    'admin@test.com',
    'Active'
);


-- 4. ربط المستخدمين بالأدوار
-- Yasser = Requester
INSERT INTO user_roles (user_id, role_id)
SELECT u.user_id, r.role_id
FROM users u
CROSS JOIN roles r
WHERE u.username = 'yasser'
  AND r.role_name = 'Requester';


-- Ahmed = Reviewer
INSERT INTO user_roles (user_id, role_id)
SELECT u.user_id, r.role_id
FROM users u
CROSS JOIN roles r
WHERE u.username = 'reviewer1'
  AND r.role_name = 'Reviewer';


-- Sara = Approver
INSERT INTO user_roles (user_id, role_id)
SELECT u.user_id, r.role_id
FROM users u
CROSS JOIN roles r
WHERE u.username = 'approver1'
  AND r.role_name = 'Approver';
INSERT INTO user_roles (user_id, role_id)
SELECT u.user_id, r.role_id
FROM users u
CROSS JOIN roles r
WHERE u.username = 'deployadmin'
  AND r.role_name = 'Deployment Admin';
INSERT INTO user_roles (user_id, role_id)
SELECT u.user_id, r.role_id
FROM users u
CROSS JOIN roles r
WHERE u.username = 'admin'
  AND r.role_name = 'System Admin';
INSERT INTO change_requests (
    request_number,
    title,
    description,
    reason,
    change_type,
    priority,
    risk_level,
    affected_database,
    affected_object,
    environment_id,
    proposed_implementation_date,
    rollback_plan,
    status,
    requester_id
)
SELECT
    'CR-2026-0001',
    'Create Customer Index',
    'Create an index on the CUSTOMER table to improve query performance.',
    'Slow queries have been observed when searching customers by email.',
    'Normal',
    'High',
    'Medium',
    'CUSTOMER_DB',
    'CUSTOMER.EMAIL',
    e.environment_id,
    SYSDATE + 7,
    'Drop the created index if deployment causes unexpected performance or functional issues.',
    'Draft',
    u.user_id
FROM users u
CROSS JOIN environments e
WHERE u.username = 'yasser'
AND e.environment_name = 'Development';
INSERT INTO change_scripts (
    request_id,
    script_name,
    script_content,
    script_type,
    execution_order
)
SELECT
    request_id,
    'Create Customer Email Index',
    'CREATE INDEX IDX_CUSTOMER_EMAIL ON CUSTOMER(EMAIL);',
    'Implementation',
    1
FROM change_requests
WHERE request_number = 'CR-2026-0001';

INSERT INTO change_scripts (
    request_id,
    script_name,
    script_content,
    script_type,
    execution_order
)
SELECT
    request_id,
    'Rollback Customer Email Index',
    'DROP INDEX IDX_CUSTOMER_EMAIL;',
    'Rollback',
    2
FROM change_requests
WHERE request_number = 'CR-2026-0001';

COMMIT;