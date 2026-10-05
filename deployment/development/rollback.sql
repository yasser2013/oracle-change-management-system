-- ============================================================
-- Oracle Change Management System - Database Rollback
-- ============================================================
-- This script ONLY removes database objects (tables + packages).
-- For APEX application removal, see rollback_apex.md
-- WARNING: This deletes all data. Use with caution.
-- ============================================================

SET DEFINE OFF
SET VERIFY OFF
SET FEEDBACK ON

PROMPT ============================================
PROMPT Rolling back Oracle Change Management System (Database)
PROMPT ============================================

PROMPT Dropping PL/SQL packages...
DROP PACKAGE pkg_change_mgmt;

PROMPT Dropping tables (in reverse FK order)...

DROP TABLE audit_log CASCADE CONSTRAINTS;
DROP TABLE change_history CASCADE CONSTRAINTS;
DROP TABLE rollbacks CASCADE CONSTRAINTS;
DROP TABLE deployments CASCADE CONSTRAINTS;
DROP TABLE test_results CASCADE CONSTRAINTS;
DROP TABLE change_approvals CASCADE CONSTRAINTS;
DROP TABLE change_reviews CASCADE CONSTRAINTS;
DROP TABLE change_scripts CASCADE CONSTRAINTS;
DROP TABLE change_requests CASCADE CONSTRAINTS;
DROP TABLE user_roles CASCADE CONSTRAINTS;
DROP TABLE environments CASCADE CONSTRAINTS;
DROP TABLE roles CASCADE CONSTRAINTS;
DROP TABLE users CASCADE CONSTRAINTS;

PROMPT ============================================
PROMPT Database rollback complete.
PROMPT ============================================