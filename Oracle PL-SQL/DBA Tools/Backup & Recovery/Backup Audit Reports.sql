-- ===============================
-- Backup Audit Reports (SQL Views)
-- ===============================
/*
Included Views & Reports:
* Daily Backup Status Summary: Totals, successes, and failures per day
* Last 7 Days Summary: Detailed list of recent backup jobs
* Failure Trend Report: Number of failed jobs per day
* Average Backup Duration: In minutes, by backup type
*/

-- 1. Daily Backup Status Summary
SELECT 
    TO_CHAR(backup_start, 'YYYY-MM-DD') AS backup_day,
    backup_type,
    COUNT(*) AS total,
    SUM(CASE WHEN status = 'SUCCESS' THEN 1 ELSE 0 END) AS successful,
    SUM(CASE WHEN status != 'SUCCESS' THEN 1 ELSE 0 END) AS failed
FROM backup_audit_log
GROUP BY TO_CHAR(backup_start, 'YYYY-MM-DD'), backup_type
ORDER BY backup_day DESC;

-- 2. Last 7 Days Backup Summary
SELECT * 
FROM (
    SELECT backup_id, backup_type, status, backup_start, backup_end, hostname, remarks
    FROM backup_audit_log
    WHERE backup_start >= SYSDATE - 7
    ORDER BY backup_start DESC
) 
WHERE ROWNUM <= 100;

-- 3. Failure Trend Report
SELECT 
    TO_CHAR(backup_start, 'YYYY-MM-DD') AS fail_date,
    COUNT(*) AS failed_jobs
FROM backup_audit_log
WHERE status != 'SUCCESS'
GROUP BY TO_CHAR(backup_start, 'YYYY-MM-DD')
ORDER BY fail_date DESC;

-- 4. Average Backup Duration
SELECT backup_type,
       ROUND(AVG(backup_end - backup_start)*24*60, 2) AS avg_duration_min
  FROM backup_audit_log
 WHERE status = 'SUCCESS'
 GROUP BY backup_type;

-- END OF TOOLKIT