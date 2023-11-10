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
echo "[Debug] generate auto configuration..."
./bin/utilities/yml_parser.sh config/conf-files/paths.yml  > config/conf-files/auto-generated/paths.sh
./bin/utilities/yml_parser.sh config/conf-files/project-config.yml  > config/conf-files/auto-generated/project-config.sh