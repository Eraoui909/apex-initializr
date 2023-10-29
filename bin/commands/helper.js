#!/usr/bin/env node

const {execSync} = require('child_process');
const fs = require('fs');
const path = require('path');

const runCommand = command => {
    try{
        execSync(`${command}`, {stdio: 'inherit', shell: '/bin/bash'});
    }catch(e){
        console.log(`Failed to execute ${command}`, e);
        return false;
    }
    return true;
}


function copyAndRenameFile(sourcePath, destinationPath, newFilename, callback) {
    const sourceFile = path.join(sourcePath);
    const destinationFile = path.join(destinationPath, newFilename);

    if (fs.existsSync(destinationFile)){
        console.log(`${destinationFile} already exist!!`);
        process.exit(-1);
    }

    fs.copyFile(sourceFile, destinationFile, (err) => {
            if (err) {
                callback(err);
            } else {
                callback(null, `File '${newFilename}' has been copied and renamed to '${destinationPath}'.`);
            }
    });
}

function replaceStringInFile(filePath, searchString, replacement, callback) {
    fs.readFile(filePath, 'utf8', (err, data) => {
        
        if (err) {
            callback(err);
            return;
        }

        const updatedData = data.replace(new RegExp(searchString, 'g'), replacement);

        fs.writeFile(filePath, updatedData, 'utf8', (writeErr) => {
            if (writeErr) {
                callback(writeErr);
            } else {
                callback(null, `String '${searchString}' replaced with '${replacement}' in ${filePath}.`);
            }
        });
    });
}

module.exports = {
    runCommand,
    copyAndRenameFile,
    replaceStringInFile
}