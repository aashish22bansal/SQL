SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY(format => 'ALL'));
-- Error: cannot fetch last explain plan from PLAN_TABLE

SELECT
    *
FROM
    ALL_OBJECTS
WHERE
        OBJECT_NAME LIKE 'PLAN%'
    AND OWNER IN (SYS_CONTEXT('userenv', 'current_schema'), 'PUBLIC', 'SYS')
;

SELECT 
    *
FROM
    TABLE(DBMS_XPLAN.DISPLAY)
;

SELECT 
    *
FROM
    PLAN_TABLE
;


EXPLAIN PLAN FOR
    SELECT 
        /*+ parallel(16) full(e) full(d) */ d.Employee_ID
    FROM
        LEARNER.EMPLOYEE E, LEARNER.DEPARTMENT D
    WHERE
        E.Department_ID = D.Department_ID
    GROUP BY
        D.Department_ID
;

SELECT 
    *
FROM
    PLAN_TABLE_OBJECT
;

SELECT 
    *
FROM
    USER_TYPES
;

SELECT 
    *
FROM
    USER_SOURCE
;

SELECT 
    DISTINCT OWNER
FROM
    ALL_TYPE_ATTRS
;

SELECT 
    DISTINCT OWNER
FROM
    USER_TYPE_ATTRS
;

SELECT 
    DISTINCT OWNER
FROM
    USER_TYPES
;