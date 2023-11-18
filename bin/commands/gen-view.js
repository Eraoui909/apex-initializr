#!/usr/bin/env node

const {copyAndRenameFile, replaceStringInFile, globalPaths} = require('./helper')

function genView(viewName){

    // make sure that you're in the root and load global paths
    const paths = globalPaths();

    let view = `${viewName}.sql`;

    console.log(`generate view ${viewName} in src/views...`);
    copyAndRenameFile(paths.file_template_view, paths.dir_src_views, view, (err, result) => {
            if (err) {
                console.error(`Error: ${err}`);
            } else {
                console.log(result);
            }
        }
    );
    //embed the view name inside the file
    replaceStringInFile(paths.dir_src_views+"/"+view, 'CHANGE_ME', viewName, (err, result) => {
        if (err) {
            console.error(`Error: ${err}`);
        } else {
            console.log(result);
        }
    });

}

module.exports = genView;