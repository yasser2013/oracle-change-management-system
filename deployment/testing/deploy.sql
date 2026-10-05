-- ============================================================
-- Oracle Change Management System - Database Deployment
-- ============================================================
-- This script ONLY deploys database objects (tables + packages).
-- For APEX application deployment, see deploy_apex.md
-- ============================================================

SET DEFINE OFF
SET VERIFY OFF
SET FEEDBACK ON

PROMPT ============================================
PROMPT Deploying tables...
PROMPT ============================================
@@../database/tables/script_tables.sql

PROMPT ============================================
PROMPT Deploying PL/SQL packages...
PROMPT ============================================
@@../database/packages/pkg_change_mgmt.sql

PROMPT ============================================
PROMPT Database deployment complete.
PROMPT Next step: Deploy APEX app (see deploy_apex.md)
PROMPT ============================================