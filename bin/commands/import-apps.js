#!/usr/bin/env node

const {runCommand, copyAndRenameFile, globalPaths} = require('./helper')
const fs = require("fs");


function importApps(ids){

    // make sure that you're in the root and load global paths
    const paths = globalPaths();

    // create the user-config.yml file if not exist
    if (!fs.existsSync(paths.file_conf_paths_yml) && !fs.existsSync(paths.file_conf_user_config)) {

        copyAndRenameFile(paths.file_template_user_config_yml, paths.dir_conf_files, "user-config.yml", (err, result) => {
                if (err) {
                    console.error(`Error: ${err}`);
                } else {
                    console.log(result);
                }
            }
        );

        console.log("The importation must fail on the first attempt");
        console.log("Before running this command again, please update the `user-config.yml` file with your connection string and the `project-config.yml` file with your parameters");

        process.exit(1);
    }

    // copy settings from user-config.yml into user-config.sh
    runCommand(`${paths.file_yml_parser} ${paths.file_conf_paths_yml}  > ${paths.file_conf_user_config}`)

    runCommand(`sh ${paths.file_import_apps} ${ids.appId}`)

}

module.exports = importApps;