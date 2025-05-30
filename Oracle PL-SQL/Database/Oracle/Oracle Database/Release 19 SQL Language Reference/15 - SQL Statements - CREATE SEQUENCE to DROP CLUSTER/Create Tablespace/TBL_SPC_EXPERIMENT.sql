/* Step 1: 
    The following example sets the default location for data file creation and then creates a tablespace with an Oracle-managed 
    temp file in the default location. The temp file is 100 M and is autoextensible with unlimited maximum size. These are the 
    default values for Oracle Managed Files:
 */
ALTER SYSTEM SET DB_CREATE_FILE_DEST = '$ORACLE_HOME/rdbms/dbs';

/* Step 2: Create Tablespace
 */
CREATE BIGFILE TABLESPACE TBL_SPC_EXPERIMENT
    DATAFILE 'TBL_SPC_EXPERIMENT.dbf'
    SIZE 20M AUTOEXTEND ON 
    ONLINE 
    EXTENT MANAGEMENT LOCAL UNIFORM SIZE 1M
;