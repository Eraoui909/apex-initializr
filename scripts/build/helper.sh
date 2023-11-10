#!/bin/bash 

##################################################
##                  Start                       ##
## this should be scoped in every single script ##
##################################################
# load global paths
# TODO hamza; What is better: to stop the process and redirect manually to the root or to redirect automatically?
global_paths="config/conf-files/auto-generated/paths.sh"
init_project="config/scripts/init-project.sh"
if ! [ -f "$global_paths" ]; then
    echo "[Error] you must be in the root folder to run this script or command!"
    echo "[Info] You will be redirected to the root folder automatically..."
    cd $(git rev-parse --show-toplevel)
    echo -n "[Info] You're in: " && pwd
fi
source $init_project
source $global_paths
##################################################
##                  End                         ##
## this should be scoped in every single script ##
##################################################

##################################################
## Script arguments                   
## $1: $DB_CONN [required]
## $2: $SQL_PLUS [required]
## $3: $SQL_CL [required]
##

if (( $# != 3 )); then
    echo "[Error] missing argument!"
    echo "[Info] Please ensure that you have passed the DB connection string, SQL*Plus, and SQLcl as arguments."
    # exit 1
fi

DB_CONN=$1
SQL_PLUS=$2
SQL_CL=$3

echo "[Debug] DB_CONN: *****"
echo "[Debug] SQL_PLUS: $SQL_PLUS"
echo "[Debug] SQL_CL: $SQL_CL"



##################################################
## export_apex_apps                    
## This function is used to export the various applications in our workspace. 
## The applications ID should be stored in $file_conf_project_config file 
##
export_apex_apps(){

    source $file_conf_project_config

    echo "[Debug] APP IDs: $APEX_APP_IDS"

    for APEX_APP_ID in $(echo $APEX_APP_IDS | sed "s/,/ /g")
    do
        echo "[Debug] APEX Export: $APEX_APP_ID ..."
        APEX_EXPORT_OPTIONS="-skipExportDate -expTranslations -expComments -expSupportingObjects Y"
        echo exit | $SQL_CL "$DB_CONN" @$file_apex_export $APEX_APP_ID "$APEX_EXPORT_OPTIONS" $dir_apex
    done

}