#!/usr/bin/env node

const {runCommand, copyAndRenameFile} = require('./helper')
const fs = require("fs");


function importApps(ids){

    // create the user-config.yml file if not exist
    if (!fs.existsSync("config/conf-files/user-config.yml") && !fs.existsSync("config/conf-files/auto-generated/user-config.sh")) {

        copyAndRenameFile("config/templates/template_user_config.yml","config/conf-files" , "user-config.yml", (err, result) => {
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
    runCommand("./bin/utilities/yml_parser.sh config/conf-files/user-config.yml  > config/conf-files/auto-generated/user-config.sh")

    runCommand(`sh scripts/tasks/import-app.sh ${ids.appId}`)

}

module.exports = importApps;