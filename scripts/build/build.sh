#!/bin/bash

# ./build.sh <version> [options]
# Parameters
#   $1 version: This is embedded in the APEX application release.
#   $2 options: comma delimited list of options that will trigger different build behavior. APEXDS-861
#     Supported options:
#     files_only: generate install.zip without making any database connections (useful for building from a tag)

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

if [ -z "$1" ]; then
  echo '[Error] Missing version number'
  exit 0
fi

VERSION=$1
OPTIONS=$2

# Lowecase all options
OPTIONS=$(tr '[:upper:]' '[:lower:]' <<< "$OPTIONS")

echo "[Debug] Version: $VERSION"
echo "[Debug] Options: $OPTIONS"

# Prevent the connection to the databse if the files_only option provided
OPTIONS_CONNECT_TO_DB_YN=Y 
if [[ "$OPTIONS" == *"files_only"* ]]; then
    OPTIONS_CONNECT_TO_DB_YN=N
fi

echo "[Debug] OPTIONS_CONNECT_TO_DB_YN: $OPTIONS_CONNECT_TO_DB_YN"


######################################################################
##                              Step 0                              ##
##                  -> Sourcing the Helper script                   ##
## -> Sourcing the User Config script (if you're not using Jenkins) ##
##  -> When utilizing Jenkins, it is necessary to provide the       ##
##                connection string as a parameter.                 ##
######################################################################

echo "[Debug] Sourcing $file_conf_user_config file..."
source $file_conf_user_config 
echo "[Debug] Sourcing $file_helper_script file..."
source $file_helper_script $DB_CONN $SQLPLUS $SQLCL

######################################################################
##                              Step 1                              ##
## Export APEX applications, defined in $file_conf_project_config   ##
######################################################################

if [ "$OPTIONS_CONNECT_TO_DB_YN" = "Y" ]; then
  export_apex_apps
else
  echo "[Info] Skipping export_apex_app"
fi

######################################################################
##                              Step 2                              ##
##                            Export ORDS                           ##
######################################################################

if [ "$OPTIONS_CONNECT_TO_DB_YN" = "Y" ]; then
  # Export ORDS
  # TODO mdsouza: 
  # cd $PROJECT_DIR/ords
  # echo exit | $SQLCL "$DB_CONN" @_export_ords.sql
  # cd $PROJECT_DIR
  echo ""
else
  echo "[Info] Skipping ORDS export"
fi

######################################################################
##                              Step 3                              ##
##                  Generate release support sql files              ##
######################################################################

#call gen_release_sql from helper script
gen_release_sql

######################################################################
##                              Step 4                              ##
##                          Generate triggers                       ##
######################################################################

if [ "$OPTIONS_CONNECT_TO_DB_YN" = "Y" ]; then
    # TODO hamza: Generate triggers
    # cd $PROJECT_DIR/triggers
    # $SQLCL "$DB_CONN" @../build/gen_bu_triggers.sql
    # cd $PROJECT_DIR
    echo ""
else
  echo "[Info] Skipping trigger generation"
fi

######################################################################
##                              Step 5                              ##
##                  Listing all views and packages                  ##
######################################################################

echo "[Info] Listing all views and packages"
# list_all_files apex release/all_apex.sql $EXT_VIEW
# # Need content in here to make it valid
# # If uncommenting also modify the copy_all_files as well
# list_all_files views release/all_views.sql $EXT_VIEW
# # use ords/ords_all.sql instead
# # list_all_files ords release/all_ords.sql $EXT_ORDS
# list_all_files packages release/all_packages.sql $EXT_PACKAGE_SPEC,$EXT_PACKAGE_BODY
# list_all_files triggers release/all_triggers.sql $EXT_VIEW

######################################################################
##                              Step 6                              ##
##               Create the install folder & Clear it               ##
######################################################################

echo "[Info] Create the install folder & Clear it"
# INSTALL_FOLDER="$PROJECT_DIR/install"
# rm -rf $INSTALL_FOLDER
# mkdir $INSTALL_FOLDER

######################################################################
##                              Step 7                              ##
##               Copy all files into the install folder             ##
######################################################################

echo "[Info] Copy all files into the install folder"
# copy_all_files apex $INSTALL_FOLDER $EXT_APEX
# copy_all_files data $INSTALL_FOLDER sql
# copy_all_files jobs $INSTALL_FOLDER sql
# copy_all_files mviews $INSTALL_FOLDER $EXT_VIEW
# copy_all_files ords $INSTALL_FOLDER $EXT_ORDS
# copy_all_files packages $INSTALL_FOLDER $EXT_PACKAGE_SPEC,$EXT_PACKAGE_BODY
# copy_all_files release/code $INSTALL_FOLDER sql
# copy_all_files release/ $INSTALL_FOLDER sql
# copy_all_files triggers $INSTALL_FOLDER $EXT_TRIGGER
# copy_all_files views $INSTALL_FOLDER $EXT_VIEW

######################################################################
##                              Step 8                              ##
##                           Disable APEX                           ##
######################################################################

echo "[Info] Disable APEX"
# cp $PROJECT_DIR/scripts/apex_disable.sql $INSTALL_FOLDER

######################################################################
##                              Step 8                              ##
##                  Rename _release.sql to install.sql              ##
######################################################################

echo "[Info] Rename _release.sql to install.sql"
# mv $INSTALL_FOLDER/_release.sql $INSTALL_FOLDER/install.sql

######################################################################
##                              Step 9                              ##
##                       Embed Version Number                       ##
######################################################################

echo "[Info] Embed Version Number $VERSION"

# for APEX_APP_ID in $(echo $APEX_APP_IDS | sed "s/,/ /g")
#   do
#     echo "APEX Export: $APEX_APP_ID"

#     # Export single file app
#     # Need to start in root project dicetory as export will automatically store files in the apex folder
#     cd $INSTALL_FOLDER

#     if [ ! -z "$VERSION" ]; then
#       # Add release number to app
#       # In order to support the various versions of sed need to add the "-bak"
#       # See: https://unix.stackexchange.com/questions/13711/differences-between-sed-on-mac-osx-and-other-standard-sed/131940#131940
#       echo "VERSION: $VERSION detected, injecting into APEX application"
#       sed -i -bak "s/%RELEASE_VERSION%/$VERSION/" f$APEX_APP_ID.sql
#       # Remove the backup version of file (see above)
#       rm f$APEX_APP_ID.sql-bak
#     fi

#     if [ "$OPTIONS_CLEAR_COOKIE_PATH_YN" = "Y" ]; then
#       # APEXDS-469: Need to manually remove the cookie path from app to work in Einstein Mig/Prod
#       echo Removing cookie path from authentication
#       # Setting will look like: 
#       # ,p_cookie_path=>'/;samesite=none'
#       sed -i -bak "s/,p_cookie_path=>'\/;samesite=none'/,p_cookie_path=>''/" f$APEX_APP_ID.sql
#       # Remove the backup version of file (see above)
#     fi

#     # APEXDS-1268: Set status to disabled (will be enabled in _release.sql after install)
#     if [ "$APEX_APP_ID" = "300000" ]; then
#       sed -i -bak "s/p_flow_status=>'AVAILABLE_W_EDIT_LINK'/p_flow_status=>'UNAVAILABLE_PLSQL'/" f$APEX_APP_ID.sql
#       # Remove the backup version of file (see VERSION above)
#       rm f$APEX_APP_ID.sql-bak
#     fi

#   done

######################################################################
##                              Step 9                              ##
##             Zip the files under the /install folder              ##
######################################################################

echo "[Info] Zip the files under the /install folder"
# zip -j $INSTALL_FOLDER/_install.zip $INSTALL_FOLDER/*