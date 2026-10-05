-- Essential data only (NO test data)
INSERT INTO roles (role_name, description) VALUES ('Requester', 'Creates change requests');
INSERT INTO roles (role_name, description) VALUES ('Reviewer', 'Reviews change requests');
INSERT INTO roles (role_name, description) VALUES ('Approver', 'Approves or rejects changes');
INSERT INTO roles (role_name, description) VALUES ('Deployment Admin', 'Deploys approved changes');
INSERT INTO roles (role_name, description) VALUES ('System Admin', 'Manages system settings');

INSERT INTO environments (environment_name, description) VALUES ('Development', 'Development environment');
INSERT INTO environments (environment_name, description) VALUES ('Testing', 'Testing environment');
INSERT INTO environments (environment_name, description) VALUES ('Production', 'Production environment');

INSERT INTO users (username, password_hash, full_name, email, status)
VALUES ('admin', 'CHANGE_ME', 'System Administrator', 'admin@company.com', 'Active');

INSERT INTO user_roles (user_id, role_id)
SELECT u.user_id, r.role_id
FROM users u CROSS JOIN roles r
WHERE u.username = 'admin' AND r.role_name = 'System Admin';

COMMIT;