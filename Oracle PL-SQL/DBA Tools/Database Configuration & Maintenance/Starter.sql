/*
This is a ready-to-use Oracle DBA Toolkit titled “Oracle Dba Scripts” containing key scripts for database creation and maintenance.

It includes:

1. DBA Queries
* Manual CREATE DATABASE
* Tablespace and datafile management
* Redo/control file scripts
* Parameter tuning
* Startup/shutdown automation
* Health checks
* Recompilation
* Basic system info

2. Shell script wrappers:
* startup_db.sh
* shutdown_db.sh
* run_health_check.sh

3. SQL Developer GUI notes:
* Save scripts as snippets
* Create custom reports
* Schedule jobs via the Scheduler tool

*/

-- ===============================
-- Oracle DBA Toolkit: Database Creation & Maintenance
-- ===============================

-- 1. CREATE DATABASE (Manual)
CREATE DATABASE mydb
   USER SYS IDENTIFIED BY MySysPass
   USER SYSTEM IDENTIFIED BY MySystemPass
   LOGFILE GROUP 1 ('/u01/oradata/mydb/redo01.log') SIZE 100M,
           GROUP 2 ('/u01/oradata/mydb/redo02.log') SIZE 100M,
           GROUP 3 ('/u01/oradata/mydb/redo03.log') SIZE 100M
   MAXLOGFILES 5
   MAXLOGMEMBERS 5
   MAXDATAFILES 100
   MAXINSTANCES 1
   CHARACTER SET AL32UTF8
   NATIONAL CHARACTER SET AL16UTF16
   DATAFILE '/u01/oradata/mydb/system01.dbf' SIZE 700M AUTOEXTEND ON
   SYSAUX DATAFILE '/u01/oradata/mydb/sysaux01.dbf' SIZE 550M AUTOEXTEND ON
   DEFAULT TEMPORARY TABLESPACE temp TEMPFILE '/u01/oradata/mydb/temp01.dbf' SIZE 100M
   UNDO TABLESPACE undotbs1 DATAFILE '/u01/oradata/mydb/undotbs01.dbf' SIZE 200M;

-- 2. CREATE TABLESPACE
CREATE TABLESPACE user_data
  DATAFILE '/u01/oradata/mydb/user_data01.dbf' SIZE 1G
  AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED;

-- 3. RESIZE DATAFILE
ALTER DATABASE DATAFILE '/u01/oradata/mydb/user_data01.dbf' RESIZE 2G;

-- 4. ADD REDO LOG GROUP
ALTER DATABASE ADD LOGFILE GROUP 4 ('/u01/oradata/mydb/redo04.log') SIZE 100M;

-- 5. BACKUP CONTROL FILE
ALTER DATABASE BACKUP CONTROLFILE TO TRACE;

-- 6. VIEW CURRENT PARAMETERS
SELECT name, value FROM v$parameter WHERE isdefault = 'FALSE';

-- 7. MODIFY PARAMETER (SPFILE)
ALTER SYSTEM SET db_cache_size = 512M SCOPE=SPFILE;

-- 8. STARTUP/SHUTDOWN
-- startup.sql
STARTUP;
-- shutdown.sql
SHUTDOWN IMMEDIATE;

-- 9. PURGE AUDIT AND RECYCLEBIN
DELETE FROM SYS.AUD$ WHERE ntimestamp# < SYSDATE - 30;
PURGE DBA_RECYCLEBIN;

-- 10. RECOMPILE INVALID OBJECTS
EXEC UTL_RECOMP.RECOMP_SERIAL();

-- 11. HEALTH CHECK SCRIPT
SELECT tablespace_name, ROUND(used_space*8/1024,2) AS used_MB, 
       ROUND((tablespace_size - used_space)*8/1024,2) AS free_MB
FROM dba_tablespace_usage_metrics;

SELECT COUNT(*) AS invalid_objects FROM dba_objects WHERE status = 'INVALID';

SELECT name, open_mode, log_mode FROM v$database;

-- 12. DATABASE INFO
SELECT * FROM v$version;
SELECT instance_name, status FROM v$instance;

-- END OF TOOLKIT










-- ===============================
-- Shell Script Wrappers (Examples)
-- ===============================

-- startup_db.sh
-- Shell script to start the database
-- Usage: chmod +x startup_db.sh && ./startup_db.sh

#!/bin/bash
export ORACLE_SID=mydb
. oraenv <<< mydb
sqlplus / as sysdba <<EOF
STARTUP;
EXIT;
EOF

-- shutdown_db.sh
-- Shell script to shutdown the database
#!/bin/bash
export ORACLE_SID=mydb
. oraenv <<< mydb
sqlplus / as sysdba <<EOF
SHUTDOWN IMMEDIATE;
EXIT;
EOF

-- run_health_check.sh
-- Generates health check report to file
#!/bin/bash
export ORACLE_SID=mydb
. oraenv <<< mydb
sqlplus -s / as sysdba <<EOF > health_report_$(date +%Y%m%d).txt
SET PAGESIZE 100
SET LINESIZE 200
@health_check.sql
EXIT;
EOF








-- ===============================
-- SQL Developer GUI Notes
-- ===============================
-- You can save any of the SQL blocks above into SQL Developer snippets
-- for reuse, or create a report panel using:
--    View > Reports > User Defined Reports > New Report
-- Paste any SELECT or DB-level script
-- Schedule with Oracle Scheduler from Tools > Scheduler > Jobs

-- END OF TOOLKIT
