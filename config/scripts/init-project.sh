################################################################################################################################################
################################################################################################################################################
##                                                            !! important !!                                                                 ##
##                              This is the first script that should be executed after project installation                                   ##
##                                                            !! important !!                                                                 ##
## Other cases, when this script should be executed:                                                                                          ##
##      -> if there is any change in paths.yml config file                                                                                    ##
##      -> if there is any change in project-config.yml config file                                                                           ##
################################################################################################################################################
################################################################################################################################################

#generate auto configuration

echo "[Debug] init the project..."

if [ ! -d "config/conf-files/auto-generated" ]; then
    mkdir -p "config/conf-files/auto-generated"
fi
./bin/utilities/yml_parser.sh config/conf-files/paths.yml  > config/conf-files/auto-generated/paths.sh
./bin/utilities/yml_parser.sh config/conf-files/project-config.yml  > config/conf-files/auto-generated/project-config.sh
if [ -f "config/conf-files/user-config.yml" ]; then
    ./bin/utilities/yml_parser.sh config/conf-files/user-config.yml  > config/conf-files/auto-generated/user-config.sh
fi
