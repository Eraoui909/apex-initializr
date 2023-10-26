#!/usr/bin/env node

const {execSync} = require('child_process');

const runCommand = command => {
    try{
        execSync(`${command}`, {stdio: 'inherit'});
    }catch(e){
        console.log(`Failed to execute ${command}`, e);
        return false;
    }
    return true;
}

const repoName = process.argv[2];
const gitCheckoutCommand = `git clone --depth 1 git@github.com:Eraoui909/apex-initializr.git ${repoName}`; 
// const installDepsCommand = `cd ${repoName} && npm install`;

console.log(`Cloning the repo with name ${repoName}`);
const checkOut = runCommand(gitCheckoutCommand);
if( !checkOut ) process.exit(-1);

// console.log(`Installing dependencies for ${repoName}`);
// const installDeps = runCommand(installDepsCommand);
// if( !installDeps ) process.exit(-1);

console.log(`Congratulations! your project has been installed`);

// console.log(`cd ${repoName} && npm install`);


