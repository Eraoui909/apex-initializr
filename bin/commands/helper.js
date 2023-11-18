#!/usr/bin/env node

const {execSync} = require('child_process');
const fs = require('fs');
const path = require('path');
const yaml = require('js-yaml');


const runCommand = command => {
    try{
        execSync(`${command}`, {stdio: 'inherit', shell: '/bin/bash'});
    }catch(e){
        console.log(`Failed to execute ${command}`, e);
        return false;
    }
    return true;
}

const globalPaths = () => {

    const yamlFilePath = 'config/conf-files/paths.yml';

     if (!fs.existsSync(yamlFilePath)) {
         console.log('You must be in the root folder to run this script or command!');
         const rootFolder = execSync('git rev-parse --show-toplevel', { encoding: 'utf8' }).trim();
         console.log(`Please make sure that you are in ${rootFolder}`)
         process.exit(1);
     }
 
    // Read the YAML file
    try {
        const yamlFileContents = fs.readFileSync(yamlFilePath, 'utf8');
        
        // Parse the YAML content
        const data = yaml.load(yamlFileContents);
        return data;

    } catch (e) {
        console.error('Error reading or parsing the YAML file:', e.message);
    }
}


function createFolder(folderName, folderPath) {
    const fullPath = path.join(folderPath, folderName);

    // Check if the folder already exists
    if (!fs.existsSync(fullPath)) {
        // Create the folder
        fs.mkdirSync(fullPath);
        console.log(`Folder '${fullPath}' created successfully.`);
        return true;
    } else {
        runCommand("rm -rf "+fullPath);
        fs.mkdirSync(fullPath);
        return false;
    }
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
    replaceStringInFile,
    createFolder,
    globalPaths
}