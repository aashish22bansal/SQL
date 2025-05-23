-- 1. Login to PDB from CDB
ALTER SESSION SET "_ORACLE_SCRIPT"=true;

-- 2. Create User
CREATE USER LEARNER
    IDENTIFIED BY LEARNER
    DEFAULT TABLESPACE TBL_SPC_LEARNER 
    QUOTA UNLIMITED ON TBL_SPC_LEARNER
;

-- 3. Grant 'CREATE SESSION' system privilege
GRANT CREATE SESSION TO LEARNER WITH ADMIN OPTION;

-- 4. Grant Other Privileges
GRANT
      CREATE ANY MATERIALIZED VIEW
    , ALTER ANY MATERIALIZED VIEW
    , DROP ANY MATERIALIZED VIEW
    , QUERY REWRITE
    , GLOBAL QUERY REWRITE
TO 
    LEARNER
WITH 
    ADMIN OPTION
;

-- 5. Check User
SHOW USER;


GRANT SELECT TO LEARNER;