#!/usr/bin/env node

const {runCommand, copyAndRenameFile, replaceStringInFile, checkRootFolder} = require('./helper')

function genPackage(packageName){

    // make sure that you're in the root
    checkRootFolder();

    let packageSpec = `${packageName}.pls`;
    let packageBody = `${packageName}.plb`;

    const packageSpecTemplate = `./config/templates/template_pkg.pls`;
    const packageBodyTemplate = `./config/templates/template_pkg.plb`;

    const tergetPath = `./src/packages`;
    const searchString = "CHANGEME";

    const package = {
        "spec": [
            packageSpec,
            packageSpecTemplate
        ],
        "body": [
            packageBody,
            packageBodyTemplate
        ]
    }

    for (const key in package) {

        console.log(`generate package ${key} in src/packages...`);
        // generate file
        copyAndRenameFile(package[key][1],tergetPath , package[key][0], (err, result) => {
                if (err) {
                    console.error(`Error: ${err}`);
                } else {
                    console.log(result);
                }
            }
        );
        runCommand("cd .");
        //embed the package name inside the file
        replaceStringInFile(tergetPath+"/"+package[key][0], searchString, packageName, (err, result) => {
            if (err) {
                console.error(`Error: ${err}`);
            } else {
                console.log(result);
            }
        });
    }
}

module.exports = genPackage;
