# Production Environment

## Files
- `deploy_prod.sql` — Deploys tables + packages + essential data
- `initial_admin.sql` — Roles, environments, and admin user

## Deployment
1. Run `deploy_prod.sql` in SQL*Plus
2. Import APEX app from `../../apex/application_exports/f143972.sql`

## Notes
- NO test data in production
- Change admin password on first login