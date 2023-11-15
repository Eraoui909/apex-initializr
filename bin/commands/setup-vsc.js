#!/usr/bin/env node

const {checkRootFolder, copyAndRenameFile, createFolder} = require('./helper')

function genView(viewName){

    // make sure that you're in the root
    checkRootFolder();

    console.log("Setup vscode snippets...")

    //create the .vscode folder
    createFolder('.vscode','./');

    // copy the snippets to the .vscode folder
    copyAndRenameFile("./config/templates/vscode/plsql.json.code-snippets","./.vscode" , "plsql.json.code-snippets", (err, result) => {
        if (err) {
            console.error(`Error: ${err}`);
        } else {
            console.log(result);
        }
    });
    copyAndRenameFile("./config/templates/vscode/sql.json.code-snippets","./.vscode" , "sql.json.code-snippets", (err, result) => {
        if (err) {
            console.error(`Error: ${err}`);
        } else {
            console.log(result);
        }
    });
    copyAndRenameFile("./config/templates/vscode/tasks.json","./.vscode" , "tasks.json", (err, result) => {
        if (err) {
            console.error(`Error: ${err}`);
        } else {
            console.log(result);
        }
    });

}

module.exports = genView;