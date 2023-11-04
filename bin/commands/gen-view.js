#!/usr/bin/env node

const {runCommand, copyAndRenameFile, replaceStringInFile} = require('./helper')

function genView(viewName){

    let view = `${viewName}.sql`;

    console.log(`generate view ${viewName} in src/views...`);
    copyAndRenameFile("./config/templates/template_view.sql","./src/views" , view, (err, result) => {
            if (err) {
                console.error(`Error: ${err}`);
            } else {
                console.log(result);
            }
        }
    );
    //embed the view name inside the file
    replaceStringInFile("./src/views/"+view, 'CHANGE_ME', viewName, (err, result) => {
        if (err) {
            console.error(`Error: ${err}`);
        } else {
            console.log(result);
        }
    });

}

module.exports = genView;