#!/usr/bin/env node

const {runCommand, copyAndRenameFile, replaceStringInFile} = require('./helper')
const fs = require("fs");

function compileFile(filePath){

    console.log("compiling ...");

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

        console.log("The compilation must fail on the first attempt");
        console.log("Please update the user-config.yml file with your connection string before running this script again");

        process.exit(1);
    }

    // copy settings from user-config.yml into user-config.sh
    runCommand("./bin/utilities/yml_parser.sh config/conf-files/user-config.yml  > config/conf-files/auto-generated/user-config.sh")


    if (fs.existsSync(filePath)) {
        runCommand(`sh config/scripts/run-sql.sh ${filePath}`)
    } else {
        console.error('The file does not exist!');
        process.exit(1); // Exit the script with an error code
    }

}

module.exports = compileFile;

 