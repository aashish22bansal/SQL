# Oracle PL/SQL DBA Tools  
## Database Configuration & Maintenance

In the Database Creation & Maintenance section of DBA tools for an Oracle SQL Database, the following types of scripts are commonly used. These scripts automate or standardize administrative tasks and can serve as a reliable toolkit for DBAs.

---

### 🧰 Scripts for Database Creation & Maintenance

#### 🔨 1. Database Creation Scripts

These are used to create a new Oracle database manually (without DBCA):

- **`create_database.sql`**  
  Includes:
  - `CREATE DATABASE` statement
  - USER SYSTEM and SYS passwords
  - Character set and national character set
  - Control file, redo logs, and archive log settings
  - `init.ora` or `spfile.ora` (Initialization parameters: memory, processes, paths, etc.)

- **`create_datafiles.sql`**  
  Creates SYSTEM, SYSAUX, UNDO, TEMP, USERS tablespaces

- **`catalog.sql`** and **`catproc.sql`**  
  Required for loading data dictionary views and PL/SQL packages

---

#### 🏗️ 2. Tablespace Management Scripts

To create and manage tablespaces and datafiles:

- **`create_tablespace.sql`**
  ```sql
  CREATE TABLESPACE user_data
    DATAFILE '/u01/app/oracle/oradata/DBNAME/user_data01.dbf' SIZE 1G
    AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED;
  ```

- **`resize_datafile.sql`**  
  Dynamically resizes an existing datafile

- **`monitor_tablespace_usage.sql`**  
  Shows used vs free space per tablespace

---

#### 🔁 3. Redo Log & Control File Scripts

- **`add_redo_log_group.sql`**
- **`switch_logfile.sql`** (for manual log switches)
- **`backup_controlfile.sql`**
  ```sql
  ALTER DATABASE BACKUP CONTROLFILE TO TRACE;
  ```

---

#### ⚙️ 4. Initialization & Parameter Scripts

- **`set_spfile_parameter.sql`**
  ```sql
  ALTER SYSTEM SET db_cache_size = 512M SCOPE = SPFILE;
  ```

- **`view_current_parameters.sql`**
- **`compare_pfile_spfile.sql`**  
  Compares startup parameters for auditing/tuning

---

#### 🧹 5. Maintenance & Housekeeping Scripts

- **`purge_audit_trail.sql`**  
  Clean old audit logs

- **`purge_recyclebin.sql`**
  ```sql
  PURGE DBA_RECYCLEBIN;
  ```

- **`clean_up_invalid_objects.sql`**  
  Recompiles invalid objects:
  ```sql
  EXEC UTL_RECOMP.RECOMP_SERIAL();
  ```

---

#### 📌 6. Startup & Shutdown Automation Scripts

- **`startup.sql`**
  ```sql
  STARTUP MOUNT;
  ALTER DATABASE OPEN;
  ```

- **`shutdown.sql`**
  ```sql
  SHUTDOWN IMMEDIATE;
  ```

These are often wrapped in shell scripts for automation:
```bash
#!/bin/bash
export ORACLE_SID=MYDB
sqlplus / as sysdba <<EOF
@startup.sql
EOF
```

---

#### 📒 7. Health & Baseline Scripts

- **`daily_health_check.sql`**  
  Validates:
  - Tablespace usage
  - Invalid objects
  - Background process status
  - Archive log status

- **`oracle_version_info.sql`**  
  Queries `v$version` and `v$instance`

- **`db_info_report.sql`**  
  Combines environment, memory, log files, and control files info

---

#### 📦 Optional Advanced Add-ons

- **`ASM_diskgroup_status.sql`** (for ASM-based storage)
- **`db_patch_level_check.sql`** (checks PSU, OJVM patch status)
-