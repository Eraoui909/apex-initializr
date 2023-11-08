#!/usr/bin/env node

const {checkRootFolder, copyAndRenameFile, replaceStringInFile} = require('./helper')

function genView(viewName){

    // make sure that you're in the root
    checkRootFolder();

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