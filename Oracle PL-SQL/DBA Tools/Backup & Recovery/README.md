# Oracle DBA Tools: Backup & Recovery

In the **Backup & Recovery** section of Oracle DBA tools, you typically work with RMAN (Recovery Manager) and SQL scripts to create a solid backup strategy and handle disaster recovery.

Below is a categorized list of the most commonly implemented scripts:

---

## 🔄 Backup & Recovery Scripts (Oracle RMAN + SQL)

### 📦 1. Full Database Backup (RMAN)

```rman
-- full_backup.rman
RUN {
  ALLOCATE CHANNEL c1 DEVICE TYPE DISK;
  BACKUP DATABASE FORMAT '/u01/backups/DB_%U.bkp';
  BACKUP CURRENT CONTROLFILE FORMAT '/u01/backups/ctrl_%U.bkp';
  RELEASE CHANNEL c1;
}
```

---

### 🧱 2. Incremental Backups (Level 0 and 1)

```rman
-- level0_backup.rman
BACKUP INCREMENTAL LEVEL 0 DATABASE FORMAT '/u01/backups/inc0_%U.bkp';

-- level1_backup.rman
BACKUP INCREMENTAL LEVEL 1 DATABASE FORMAT '/u01/backups/inc1_%U.bkp';
```

---

### 🧾 3. Archive Log Backup

```rman
-- archive_backup.rman
BACKUP ARCHIVELOG ALL DELETE INPUT FORMAT '/u01/backups/arch_%U.arc';
```

---

### 🧮 4. Control File and SPFILE Backup

```rman
-- backup_control_spfile.rman
BACKUP CURRENT CONTROLFILE FORMAT '/u01/backups/ctrl_%U.bkp';

BACKUP SPFILE FORMAT '/u01/backups/spfile_%U.bkp';
```

---

### 🔁 5. Restore & Recovery Scripts

```rman
-- restore_db.rman
RUN {
  STARTUP MOUNT;
  RESTORE DATABASE;
  RECOVER DATABASE;
  ALTER DATABASE OPEN RESETLOGS;
}
```

---

### 🕰️ 6. Point-In-Time Recovery (PITR)

```rman
-- point_in_time_recovery.rman
RUN {
  SET UNTIL TIME "TO_DATE('2025-06-18 23:59:00','YYYY-MM-DD HH24:MI:SS')";
  RESTORE DATABASE;
  RECOVER DATABASE;
  ALTER DATABASE OPEN RESETLOGS;
}
```

---

### 🗂️ 7. Tablespace Backup & Recovery

```rman
-- backup_tablespace.rman
BACKUP TABLESPACE users FORMAT '/u01/backups/users_ts_%U.bkp';

-- restore_tablespace.rman
RUN {
  RESTORE TABLESPACE users;
  RECOVER TABLESPACE users;
}
```

---

### 💬 8. Validation Scripts

```rman
-- validate_backup.rman
VALIDATE BACKUPSET '/u01/backups/DB_1nnn.bkp';

-- validate_database.rman
VALIDATE DATABASE;
```

---

### 🧼 9. Backup Deletion / Retention Management

```rman
-- delete_old_backups.rman
DELETE NOPROMPT BACKUP COMPLETED BEFORE 'SYSDATE-7';

-- crosscheck_and_delete.rman
CROSSCHECK BACKUP;
DELETE EXPIRED BACKUP;
```

---

### 📃 10. Backup Logs and Status Reports

```sql
-- List RMAN backup history
SELECT START_TIME, END_TIME, STATUS, INPUT_TYPE 
FROM V$RMAN_BACKUP_JOB_DETAILS 
ORDER BY START_TIME DESC;

-- List backup pieces
SELECT PIECE#, STATUS, START_TIME, COMPLETION_TIME, HANDLE 
FROM V$BACKUP_PIECE 
ORDER BY COMPLETION_TIME DESC;
```

---

## 🛠️ Bonus Utility Scripts

| Script Name                | Purpose                          |
|----------------------------|----------------------------------|
| backup_config_show.rman    | Shows current RMAN config        |
| backup_summary_report.sql  | Summarizes recent backup jobs    |
| archivelog_gap_check.sql   | Detects archive log gaps         |
| rman_env_setup.sh          | Wrapper to set environment and run RMAN jobs |

---

## ⏰ Automation Options

- **Unix/Linux:** Use `cron` to schedule RMAN shell wrappers.
- **Windows:** Use Task Scheduler to call `.bat` files 






## Backup & Recovery section with:

1. RMAN Scripts:
    * Full & incremental backups
    * Archive log, control file, SPFILE backups
    * Restore, recovery, PITR, tablespace restore
    * Validation & retention cleanup
    * Backup job reports
2. Shell Wrappers (`.sh`):
    * `full_backup.sh`, `archive_backup.sh`, `validate_db.sh`
3. Automation Setup:
    * Linux `cron` jobs
    * Windows `.bat` files + Task Scheduler setup






## 📧 Email Alert Script (`email_alert.sh`)
* Sends a success or failure email after each backup
* Can be integrated into existing `.sh` files

## 📋 Backup Audit Table
* Logs each backup attempt with:
  * Type
  * Status
  * Timestamps
  * Hostname
  * Log file path
  * Remarks
* Use SQL*Plus inside shell scripts to insert entries post-backup






## 📊 Included Views & Reports
1. Daily Backup Status Summary: Totals, successes, and failures per day
2. Last 7 Days Summary: Detailed list of recent backup jobs
3. Failure Trend Report: Number of failed jobs per day
4. Average Backup Duration: In minutes, by backup type






## 📊 SQL Developer Dashboard
* Step-by-step guide to create a visual backup summary using built-in reporting tools
* Customize as chart, table, or pie view

## 🌐 HTML Auto-Generated Report
* Shell script `generate_backup_dashboard.sh`:
  * Converts latest audit logs to an HTML page
  * Ready to deploy under `/u01/reports`
* Can be automated via `cron`