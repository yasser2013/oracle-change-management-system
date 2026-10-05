CREATE OR REPLACE PACKAGE pkg_change_mgmt AS

    PROCEDURE create_change_request(
        p_title         IN  VARCHAR2,
        p_description   IN  CLOB,
        p_reason        IN  CLOB,
        p_requester_id  IN  NUMBER,
        p_request_id    OUT NUMBER
    );

    PROCEDURE submit_request(
        p_request_id    IN NUMBER,
        p_user_id       IN NUMBER
    );

PROCEDURE review_request(
    p_request_id IN NUMBER,
    p_reviewer_id IN NUMBER,
    p_comments IN CLOB
);

    PROCEDURE approve_request(
        p_request_id    IN NUMBER,
        p_approver_id   IN NUMBER,
        p_comments      IN CLOB
    );

    PROCEDURE reject_request(
        p_request_id    IN NUMBER,
        p_approver_id   IN NUMBER,
        p_comments      IN CLOB
    );

    FUNCTION get_all_requests
        RETURN SYS_REFCURSOR;

END pkg_change_mgmt;
/
CREATE OR REPLACE PACKAGE BODY pkg_change_mgmt AS

    PROCEDURE create_change_request(
        p_title         IN  VARCHAR2,
        p_description   IN  CLOB,
        p_reason        IN  CLOB,
        p_requester_id  IN  NUMBER,
        p_request_id    OUT NUMBER
    ) IS

        v_request_number VARCHAR2(30);

    BEGIN

        IF p_title IS NULL THEN
            RAISE_APPLICATION_ERROR(
                -20001,
                'Change request title is required'
            );
        END IF;

        IF p_description IS NULL THEN
            RAISE_APPLICATION_ERROR(
                -20002,
                'Description is required'
            );
        END IF;

        IF p_reason IS NULL THEN
            RAISE_APPLICATION_ERROR(
                -20003,
                'Reason is required'
            );
        END IF;

        SELECT 'CR-' ||
               TO_CHAR(SYSDATE, 'YYYYMMDD') ||
               '-' ||
               LPAD(NVL(MAX(request_id), 0) + 1, 4, '0')
        INTO v_request_number
        FROM change_requests;

        INSERT INTO change_requests (
            request_number,
            title,
            description,
            reason,
            change_type,
            priority,
            risk_level,
            status,
            requester_id,
            created_at
        )
        VALUES (
            v_request_number,
            p_title,
            p_description,
            p_reason,
            'Normal',
            'Medium',
            'Low',
            'Draft',
            p_requester_id,
            SYSDATE
        )
        RETURNING request_id INTO p_request_id;

        INSERT INTO change_history (
            request_id,
            changed_by,
            old_status,
            new_status,
            comments
        )
        VALUES (
            p_request_id,
            p_requester_id,
            NULL,
            'Draft',
            'Change request created'
        );

        COMMIT;

    END create_change_request;


    PROCEDURE submit_request(
        p_request_id IN NUMBER,
        p_user_id    IN NUMBER
    ) IS

        v_status       change_requests.status%TYPE;
        v_requester_id change_requests.requester_id%TYPE;

    BEGIN

        SELECT status, requester_id
        INTO v_status, v_requester_id
        FROM change_requests
        WHERE request_id = p_request_id;

        IF v_requester_id <> p_user_id THEN
            RAISE_APPLICATION_ERROR(
                -20004,
                'Only the requester can submit this request'
            );
        END IF;

        IF v_status <> 'Draft' THEN
            RAISE_APPLICATION_ERROR(
                -20005,
                'Only Draft requests can be submitted'
            );
        END IF;

        UPDATE change_requests
        SET status = 'Submitted',
            updated_at = SYSDATE
        WHERE request_id = p_request_id;

        INSERT INTO change_history (
            request_id,
            changed_by,
            old_status,
            new_status,
            comments
        )
        VALUES (
            p_request_id,
            p_user_id,
            'Draft',
            'Submitted',
            'Change request submitted for review'
        );

        COMMIT;

    END submit_request;

create or replace PACKAGE BODY pkg_change_mgmt AS

    PROCEDURE create_change_request(
        p_title         IN  VARCHAR2,
        p_description   IN  CLOB,
        p_reason        IN  CLOB,
        p_requester_id  IN  NUMBER,
        p_request_id    OUT NUMBER
    ) IS

        v_request_number VARCHAR2(30);

    BEGIN

        IF p_title IS NULL THEN
            RAISE_APPLICATION_ERROR(
                -20001,
                'Change request title is required'
            );
        END IF;

        IF p_description IS NULL THEN
            RAISE_APPLICATION_ERROR(
                -20002,
                'Description is required'
            );
        END IF;

        IF p_reason IS NULL THEN
            RAISE_APPLICATION_ERROR(
                -20003,
                'Reason is required'
            );
        END IF;

        SELECT 'CR-' ||
               TO_CHAR(SYSDATE, 'YYYYMMDD') ||
               '-' ||
               LPAD(NVL(MAX(request_id), 0) + 1, 4, '0')
        INTO v_request_number
        FROM change_requests;

        INSERT INTO change_requests (
            request_number,
            title,
            description,
            reason,
            change_type,
            priority,
            risk_level,
            status,
            requester_id,
            created_at
        )
        VALUES (
            v_request_number,
            p_title,
            p_description,
            p_reason,
            'Normal',
            'Medium',
            'Low',
            'Draft',
            p_requester_id,
            SYSDATE
        )
        RETURNING request_id INTO p_request_id;

        INSERT INTO change_history (
            request_id,
            changed_by,
            old_status,
            new_status,
            comments
        )
        VALUES (
            p_request_id,
            p_requester_id,
            NULL,
            'Draft',
            'Change request created'
        );

        COMMIT;

    END create_change_request;


    PROCEDURE submit_request(
        p_request_id IN NUMBER,
        p_user_id    IN NUMBER
    ) IS

        v_status       change_requests.status%TYPE;
        v_requester_id change_requests.requester_id%TYPE;

    BEGIN

        SELECT status, requester_id
        INTO v_status, v_requester_id
        FROM change_requests
        WHERE request_id = p_request_id;

        IF v_requester_id <> p_user_id THEN
            RAISE_APPLICATION_ERROR(
                -20004,
                'Only the requester can submit this request'
            );
        END IF;

        IF v_status <> 'Draft' THEN
            RAISE_APPLICATION_ERROR(
                -20005,
                'Only Draft requests can be submitted'
            );
        END IF;

        UPDATE change_requests
        SET status = 'Submitted',
            updated_at = SYSDATE
        WHERE request_id = p_request_id;

        INSERT INTO change_history (
            request_id,
            changed_by,
            old_status,
            new_status,
            comments
        )
        VALUES (
            p_request_id,
            p_user_id,
            'Draft',
            'Submitted',
            'Change request submitted for review'
        );

        COMMIT;

    END submit_request;

PROCEDURE review_request(
    p_request_id  IN NUMBER,
    p_reviewer_id IN NUMBER,
    p_comments    IN CLOB
) IS
    v_status change_requests.status%TYPE;
BEGIN
    SELECT status
      INTO v_status
      FROM change_requests
     WHERE request_id = p_request_id;

    IF v_status <> 'Submitted' THEN
        RAISE_APPLICATION_ERROR(
            -20010,
            'Only Submitted requests can be moved to Under Review'
        );
    END IF;

    UPDATE change_requests
       SET status = 'Under Review',
           updated_at = SYSDATE
     WHERE request_id = p_request_id;

    INSERT INTO change_reviews (
        request_id,
        reviewer_id,
        review_status,
        comments,
        reviewed_at
    )
    VALUES (
        p_request_id,
        p_reviewer_id,
        'Under Review',
        p_comments,
        SYSDATE
    );

    INSERT INTO change_history (
        request_id,
        changed_by,
        old_status,
        new_status,
        comments
    )
    VALUES (
        p_request_id,
        p_reviewer_id,
        'Submitted',
        'Under Review',
        p_comments
    );

    COMMIT;
END review_request;
    PROCEDURE approve_request(
        p_request_id  IN NUMBER,
        p_approver_id IN NUMBER,
        p_comments    IN CLOB
    ) IS

        v_status       change_requests.status%TYPE;
        v_requester_id change_requests.requester_id%TYPE;

    BEGIN

        SELECT status, requester_id
        INTO v_status, v_requester_id
        FROM change_requests
        WHERE request_id = p_request_id;

        IF v_requester_id = p_approver_id THEN
            RAISE_APPLICATION_ERROR(
                -20006,
                'Requester cannot approve their own change'
            );
        END IF;

        IF v_status <> 'Under Review' THEN
            RAISE_APPLICATION_ERROR(
                -20007,
                'Only requests under review can be approved'
            );
        END IF;

        INSERT INTO change_approvals (
            request_id,
            approver_id,
            approval_level,
            decision,
            comments,
            decision_date
        )
        VALUES (
            p_request_id,
            p_approver_id,
            1,
            'Approved',
            p_comments,
            SYSDATE
        );

        UPDATE change_requests
        SET status = 'Approved',
            updated_at = SYSDATE
        WHERE request_id = p_request_id;

        INSERT INTO change_history (
            request_id,
            changed_by,
            old_status,
            new_status,
            comments
        )
        VALUES (
            p_request_id,
            p_approver_id,
            'Under Review',
            'Approved',
            p_comments
        );

        COMMIT;

    END approve_request;


    PROCEDURE reject_request(
        p_request_id  IN NUMBER,
        p_approver_id IN NUMBER,
        p_comments    IN CLOB
    ) IS

        v_status       change_requests.status%TYPE;
        v_requester_id change_requests.requester_id%TYPE;

    BEGIN

        SELECT status, requester_id
        INTO v_status, v_requester_id
        FROM change_requests
        WHERE request_id = p_request_id;

        IF v_requester_id = p_approver_id THEN
            RAISE_APPLICATION_ERROR(
                -20008,
                'Requester cannot reject their own change'
            );
        END IF;

        IF v_status <> 'Under Review' THEN
            RAISE_APPLICATION_ERROR(
                -20009,
                'Only requests under review can be rejected'
            );
        END IF;

        INSERT INTO change_approvals (
            request_id,
            approver_id,
            approval_level,
            decision,
            comments,
            decision_date
        )
        VALUES (
            p_request_id,
            p_approver_id,
            1,
            'Rejected',
            p_comments,
            SYSDATE
        );

        UPDATE change_requests
        SET status = 'Rejected',
            updated_at = SYSDATE
        WHERE request_id = p_request_id;

        INSERT INTO change_history (
            request_id,
            changed_by,
            old_status,
            new_status,
            comments
        )
        VALUES (
            p_request_id,
            p_approver_id,
            'Under Review',
            'Rejected',
            p_comments
        );

        COMMIT;

    END reject_request;


    FUNCTION get_all_requests
        RETURN SYS_REFCURSOR
    IS

        v_cursor SYS_REFCURSOR;

    BEGIN

        OPEN v_cursor FOR
            SELECT
                request_id,
                request_number,
                title,
                change_type,
                priority,
                risk_level,
                status,
                requester_id,
                created_at,
                updated_at
            FROM change_requests
            ORDER BY created_at DESC;

        RETURN v_cursor;

    END get_all_requests;

END pkg_change_mgmt;

    PROCEDURE approve_request(
        p_request_id  IN NUMBER,
        p_approver_id IN NUMBER,
        p_comments    IN CLOB
    ) IS

        v_status       change_requests.status%TYPE;
        v_requester_id change_requests.requester_id%TYPE;

    BEGIN

        SELECT status, requester_id
        INTO v_status, v_requester_id
        FROM change_requests
        WHERE request_id = p_request_id;

        IF v_requester_id = p_approver_id THEN
            RAISE_APPLICATION_ERROR(
                -20006,
                'Requester cannot approve their own change'
            );
        END IF;

        IF v_status <> 'Under Review' THEN
            RAISE_APPLICATION_ERROR(
                -20007,
                'Only requests under review can be approved'
            );
        END IF;

        INSERT INTO change_approvals (
            request_id,
            approver_id,
            approval_level,
            decision,
            comments,
            decision_date
        )
        VALUES (
            p_request_id,
            p_approver_id,
            1,
            'Approved',
            p_comments,
            SYSDATE
        );

        UPDATE change_requests
        SET status = 'Approved',
            updated_at = SYSDATE
        WHERE request_id = p_request_id;

        INSERT INTO change_history (
            request_id,
            changed_by,
            old_status,
            new_status,
            comments
        )
        VALUES (
            p_request_id,
            p_approver_id,
            'Under Review',
            'Approved',
            p_comments
        );

        COMMIT;

    END approve_request;


    PROCEDURE reject_request(
        p_request_id  IN NUMBER,
        p_approver_id IN NUMBER,
        p_comments    IN CLOB
    ) IS

        v_status       change_requests.status%TYPE;
        v_requester_id change_requests.requester_id%TYPE;

    BEGIN

        SELECT status, requester_id
        INTO v_status, v_requester_id
        FROM change_requests
        WHERE request_id = p_request_id;

        IF v_requester_id = p_approver_id THEN
            RAISE_APPLICATION_ERROR(
                -20008,
                'Requester cannot reject their own change'
            );
        END IF;

        IF v_status <> 'Under Review' THEN
            RAISE_APPLICATION_ERROR(
                -20009,
                'Only requests under review can be rejected'
            );
        END IF;

        INSERT INTO change_approvals (
            request_id,
            approver_id,
            approval_level,
            decision,
            comments,
            decision_date
        )
        VALUES (
            p_request_id,
            p_approver_id,
            1,
            'Rejected',
            p_comments,
            SYSDATE
        );

        UPDATE change_requests
        SET status = 'Rejected',
            updated_at = SYSDATE
        WHERE request_id = p_request_id;

        INSERT INTO change_history (
            request_id,
            changed_by,
            old_status,
            new_status,
            comments
        )
        VALUES (
            p_request_id,
            p_approver_id,
            'Under Review',
            'Rejected',
            p_comments
        );

        COMMIT;

    END reject_request;


    FUNCTION get_all_requests
        RETURN SYS_REFCURSOR
    IS

        v_cursor SYS_REFCURSOR;

    BEGIN

        OPEN v_cursor FOR
            SELECT
                request_id,
                request_number,
                title,
                change_type,
                priority,
                risk_level,
                status,
                requester_id,
                created_at,
                updated_at
            FROM change_requests
            ORDER BY created_at DESC;

        RETURN v_cursor;

    END get_all_requests;

END pkg_change_mgmt;
/
