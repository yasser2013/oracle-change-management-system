CREATE OR REPLACE FUNCTION fn_apex_authenticate (
    p_username IN VARCHAR2,
    p_password IN VARCHAR2
) RETURN BOOLEAN
IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM users
    WHERE UPPER(username) = UPPER(p_username)
      AND password_hash = p_password
      AND status = 'Active';

    RETURN v_count = 1;

EXCEPTION
    WHEN OTHERS THEN
        RETURN FALSE;
END;
/