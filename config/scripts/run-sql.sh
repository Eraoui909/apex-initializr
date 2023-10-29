#!/bin/bash -ex

# Env variables $1, $2, etc are from the tasks.json args array

# Directory of this file
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "./config/conf-files/auto-generated/user-config.sh"

# File can be referenced either as a full path or relative path
#TODO hamza: check if the file exist
FILE_PATH=$1


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
-- #38: This will raise a warning message in SQL*Plus but worth keeping in to encourage use if using SQLcl to compile
set codescan all
--
-- Load user specific commands here
--
-- 
-- Run file
--
@$FILE_PATH
set define on
show errors
exit;
EOF
