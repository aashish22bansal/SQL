SELECT PIECE#, STATUS, START_TIME, COMPLETION_TIME, HANDLE 
FROM V$BACKUP_PIECE 
ORDER BY COMPLETION_TIME DESC;