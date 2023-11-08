#!/bin/bash 

##################################################
##                  Start                       ##
## this should be scoped in every single script ##
##################################################
# load global paths
# TODO hamza; What is better: to stop the process and redirect manually to the root or to redirect automatically?
global_paths="config/conf-files/auto-generated/paths.sh"
if ! [ -f "$global_paths" ]; then
    echo "you must be in the root folder to run this script or command!"
    echo "You will be redirected to the root folder automatically..."
    cd $(git rev-parse --show-toplevel)
    echo "You're in" && pwd
fi
source $global_paths
##################################################
##                  End                         ##
## this should be scoped in every single script ##
##################################################


# load db_connection and sqlplus
source $file_conf_user_config

# File can be referenced either as a full path or relative path
file_path=$1
if [ -f "$file_path" ]; then
    echo "$file_path exists."
else
    echo "$file_path does not exist."
    exit 1
fi



# run sqlplus, execute the script, then get the error list and exit
# VSCODE_TASK_COMPILE_BIN is set in the config.sh file (either sqlplus or sqlcl)
# Note: need to put quotes around $DB_CONN as the connection string for OCI has spaces and will be interprited as different filename
$SQLPLUS $DB_CONN << EOF
set define off
--
-- Set any alter session statements here (examples below)
-- alter session set plsql_ccflags = 'dev_env:true';
-- alter session set plsql_warnings = 'ENABLE:ALL';
-- 
-- This will raise a warning message in SQL*Plus but worth keeping in to encourage use if using SQLcl to compile
set codescan all
--
-- Load user specific commands here
--
-- 
-- Run file
--
@$file_path
set define on
show errors
exit;
EOF
