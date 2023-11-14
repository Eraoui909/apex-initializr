prompt generating bu triggers (will take a while)
set serveroutput on
set termout off
set echo off
set feedback off
-- Linesize is required otherwise some of the triggers will have new line feeds on the exec statement
set linesize 4000
spool __gen_all_triggers.sql
exec app_qa_util_trigger.generate_triggers(p_gen_sql_script_yn => 'Y');
spool off
@__gen_all_triggers.sql
-- Remove the file
host rm __gen_all_triggers.sql

-- exit
exit