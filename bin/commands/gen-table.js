#!/usr/bin/env node

const {copyAndRenameFile, replaceStringInFile, globalPaths} = require('./helper')

function genTable(tableName){

    // make sure that you're in the root and load global paths
    const paths = globalPaths();

    let table = `${tableName}.sql`;

    console.log(`generate table ${tableName} in ${paths.dir_src_tables}...`);
    copyAndRenameFile(paths.file_template_table, paths.dir_src_tables, table, (err, result) => {
            if (err) {
                console.error(`Error: ${err}`);
            } else {
                console.log(result);
            }
        }
    );
    //embed the table name inside the file
    replaceStringInFile(paths.dir_src_tables+"/"+table, 'CHANGE_ME', tableName, (err, result) => {
        if (err) {
            console.error(`Error: ${err}`);
        } else {
            console.log(result);
        }
    });

}

module.exports = genTable;