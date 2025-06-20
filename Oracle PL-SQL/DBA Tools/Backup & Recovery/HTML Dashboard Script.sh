-- ===============================
-- HTML Dashboard Script (Optional Shell-Based)
-- ===============================

-- File: generate_backup_dashboard.sh
#!/bin/bash
sqlplus -s / as sysdba <<EOF > /u01/reports/backup_dashboard.html
SET MARKUP HTML ON SPOOL ON PREFORMAT OFF ENTMAP ON
SPOOL /u01/reports/backup_dashboard.html
SELECT * FROM (
  SELECT TO_CHAR(backup_start, 'YYYY-MM-DD HH24:MI') AS start_time,
         backup_type, status, hostname
    FROM backup_audit_log
   ORDER BY backup_start DESC
) WHERE ROWNUM <= 20;
SPOOL OFF
EXIT;
EOF

-- Schedule in crontab for daily generation:
0 8 * * * /u01/scripts/generate_backup_dashboard.sh

-- END OF TOOLKIT