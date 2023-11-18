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
source "config/scripts/init-project.sh"
source $global_paths
##################################################
##                  End                         ##
## this should be scoped in every single script ##
##################################################

APP_IDS=$1

# source the user-config.sh
source $file_conf_user_config;

if [[ "$APP_IDS" == *"APEX_APP_IDS"* ]] 
then

    echo "[Debug] use default APP IDS from $file_conf_project_config";
    source $file_conf_project_config;
    APP_IDS=$APEX_APP_IDS    
fi



for APP_ID in $(echo $APP_IDS | sed "s/,/ /g")
do
    if ! [[ $APP_ID =~ ^[0-9]+$ ]]; then
        echo "[Error] Please ensure that the IDs are provided in numerical format"
        echo "[Info] This ID ($APP_ID) will be skipped"
    else
        echo "[Debug] Exporting app $APP_ID ..."
        echo "[Debug] Export options $APEX_EXPORT_OPTIONS"
        echo "[Debug] The export will be in $dir_src_apex"

        $SQLCL $DB_CONN << EOF
            whenever sqlerror exit failure
            apex export -applicationid $APP_ID -dir $dir_src_apex $APEX_EXPORT_OPTIONS
EOF
    fi
    
done
