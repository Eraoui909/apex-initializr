#!/usr/bin/env node

const {copyAndRenameFile, createFolder, globalPaths} = require('./helper')

function genView(viewName){

    // make sure that you're in the root and load global paths
    const paths = globalPaths();

    console.log("Setup vscode snippets...")

    //create the .vscode folder
    createFolder(paths.dir_vscode, paths.dir_root);

    // copy the snippets to the .vscode folder
    copyAndRenameFile(paths.file_plsql_snippets, paths.dir_vscode, "plsql.json.code-snippets", (err, result) => {
        if (err) {
            console.error(`Error: ${err}`);
        } else {
            console.log(result);
        }
    });
    copyAndRenameFile(paths.file_sql_snippets, paths.dir_vscode, "sql.json.code-snippets", (err, result) => {
        if (err) {
            console.error(`Error: ${err}`);
        } else {
            console.log(result);
        }
    });
    copyAndRenameFile(paths.file_vsc_tasks ,paths.dir_vscode , "tasks.json", (err, result) => {
        if (err) {
            console.error(`Error: ${err}`);
        } else {
            console.log(result);
        }
    });

}

module.exports = genView;