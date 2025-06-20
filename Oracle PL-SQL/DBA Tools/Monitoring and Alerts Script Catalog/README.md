# Oracle DBA Tools: Monitoring & Alerts Script Catalog

In the **Monitoring & Alerts** section of Oracle DBA tools, scripts are designed to detect issues before they impact the system, notify DBAs, and provide insight into performance, availability, and space management.

---

## 📡 Monitoring & Alerts Script Catalog

### 🧠 1. Instance Health Check Script

Checks key health indicators.

```sql
-- instance_health.sql
SELECT status, database_status, instance_name, host_name FROM v$instance;
SELECT name, open_mode, log_mode FROM v$database;
SELECT COUNT(*) invalid_objects FROM dba_objects WHERE status = 'INVALID';
```

---

### 💽 2. Tablespace Usage Monitoring

Alerts on critical usage thresholds.

```sql
-- monitor_tablespace.sql
SELECT 
    tablespace_name,
    ROUND(used_percent, 2) AS used_pct
FROM dba_tablespace_usage_metrics
WHERE used_percent > 85;
```

You can wrap this in a shell script to send email alerts if critical thresholds are breached.

---

### 🗂️ 3. Datafile Autoextend & Free Space

```sql
-- datafile_space.sql
SELECT 
    file_name, 
    tablespace_name, 
    bytes/1024/1024 AS size_mb,
    autoextensible, 
    maxbytes/1024/1024 AS max_mb
FROM dba_data_files
WHERE 
        autoextensible = 'NO' 
    OR  bytes/maxbytes > 0.9
;
```

---

### 🕵️ 4. Archive Log Usage Monitoring

Prevents ARCH process failures.

```sql
-- archive_dest_usage.sql
SELECT 
    DEST_ID, 
    DEST_NAME, 
    STATUS, 
    SPACE_LIMIT/1024/1024 AS limit_mb,
    SPACE_USED/1024/1024 AS used_mb,
    ROUND((SPACE_USED / SPACE_LIMIT) * 100, 2) AS used_pct
FROM V$ARCHIVED_LOG_DEST
WHERE SPACE_USED / SPACE_LIMIT > 0.85;
```

---

### 🔄 5. RMAN Backup Status Monitor

Detects failures in recent jobs.

```sql
-- rman_backup_check.sql
SELECT 
    STATUS, 
    TO_CHAR(START_TIME, 'YYYY-MM-DD HH24:MI') AS started,
    TO_CHAR(END_TIME, 'YYYY-MM-DD HH24:MI') AS ended,
    INPUT_TYPE, 
    OUTPUT_DEVICE_TYPE
FROM V$RMAN_BACKUP_JOB_DETAILS
WHERE 
        START_TIME > SYSDATE - 1
    AND STATUS != 'COMPLETED';
```

---

### 🔁 6. Blocked Sessions Detector

```sql
-- blocked_sessions.sql
SELECT 
    s1.username || '@' || s1.machine || ' (SID=' || s1.sid || ')' AS blocker,
    s2.username || '@' || s2.machine || ' (SID=' || s2.sid || ')' AS blocked
FROM 
    v$lock l1, 
    v$session s1, 
    v$lock l2, 
    v$session s2
WHERE 
        s1.sid = l1.sid 
    AND s2.sid = l2.sid
    AND l1.BLOCK = 1 
    AND l2.request > 0
    AND l1.id1 = l2.id1 
    AND l1.id2 = l2.id2
;
```

---

### 📉 7. Session Count and Load Monitoring

```sql
-- active_sessions.sql
SELECT COUNT(*) AS active_sessions
FROM v$session
WHERE 
        status = 'ACTIVE' 
    AND username IS NOT NULL
;
```

```sql
-- high_cpu_sessions.sql
SELECT 
    s.sid, 
    s.serial#, 
    s.username, 
    s.program, 
    se.value/100 AS cpu_seconds
FROM 
    v$session s, 
    v$sesstat se, 
    v$statname sn
WHERE 
        se.statistic# = sn.statistic#
    AND sn.name = 'CPU used by this session'
    AND se.sid = s.sid
    AND se.value > 1000000
ORDER BY 
    se.value DESC
;
```

---

### 📬 8. Email Alert Shell Wrapper

Example for space monitoring:

```bash
#!/bin/bash
sqlplus -s / as sysdba <<EOF > /tmp/space_alert.txt
SET HEADING OFF
SET FEEDBACK OFF

SELECT tablespace_name, ROUND(used_percent, 2)
FROM dba_tablespace_usage_metrics
WHERE used_percent > 85;
EOF

if grep -q "%" /tmp/space_alert.txt; then
  mail -s "⚠️ Oracle Tablespace Alert on $(hostname)" dba_team@example.com < /tmp/space_alert.txt
fi
```

---

### 📈 9. Monitoring Integration Add-ons

* Integrate with:
    - Nagios/Check_MK
    - Zabbix
    - Oracle Enterprise Manager
* Use `check_oracle_health` plugin or REST APIs with shell scripts.


### 📦 10. monitoring_alert_log Table
* Logs:
    * Alert type
    * Timestamp
    * Hostname
    * Message
    * Severity (WARNING, CRITICAL, etc.)

🧩 Shell Script Integration
* `tablespace_alert.sh` now inserts an alert entry whenever usage exceeds the threshold.



### 📊 11. Monitoring Alert Summary Reports
1. `alert_summary_daily.sql`
    * Daily alert counts by type and severity
2. `alert_trend_last7.sql`
    * Frequency of alert types in the last 7 days