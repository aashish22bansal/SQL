#!/bin/bash
EMAIL="dba_team@example.com"
LOG_FILE="/u01/logs/full_backup_$(date +%Y%m%d).log"

if grep -q "ORA-" "$LOG_FILE"; then
  mail -s "[ALERT] Oracle Backup Failed on $(hostname)" "$EMAIL" < "$LOG_FILE"
else
  mail -s "[INFO] Oracle Backup Successful on $(hostname)" "$EMAIL" < "$LOG_FILE"
fi