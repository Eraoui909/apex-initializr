#!/usr/bin/env node

const {runCommand, copyAndRenameFile, replaceStringInFile, globalPaths} = require('./helper')

function genPackage(packageName){

    // make sure that you're in the root and load global paths
    const paths = globalPaths();

    let packageSpec = `${packageName}.pls`;
    let packageBody = `${packageName}.plb`;

    const packageSpecTemplate = paths.file_template_pkg_spec;
    const packageBodyTemplate = paths.file_template_pkg_body;

    const tergetPath = paths.dir_src_packages;
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

        console.log(`generate package ${key} in ${tergetPath}...`);
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
