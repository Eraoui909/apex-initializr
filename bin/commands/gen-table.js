#!/usr/bin/env node

const {runCommand, copyAndRenameFile, replaceStringInFile} = require('./helper')

function genTable(tableName){

    let table = `${tableName}.sql`;

    console.log(`generate table ${tableName} in src/tables...`);
    copyAndRenameFile("./config/templates/template_table.sql","./src/tables" , table, (err, result) => {
            if (err) {
                console.error(`Error: ${err}`);
            } else {
                console.log(result);
            }
        }
    );
    //embed the table name inside the file
    replaceStringInFile("./src/tables/"+table, 'CHANGE_ME', tableName, (err, result) => {
        if (err) {
            console.error(`Error: ${err}`);
        } else {
            console.log(result);
        }
    });

}

module.exports = genTable;