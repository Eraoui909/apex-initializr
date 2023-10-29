#!/usr/bin/env node

const {runCommand} = require('./helper')

function initialize(projectName){

    
    const repoName = projectName;
    if( repoName === undefined) {
    
        console.log("Project name is required");
        process.exit(-1);
    }
    
    const gitCheckoutCommand = `git clone --depth 1 git@github.com:Eraoui909/apex-initializr.git ${repoName}`; 
    const gitRemoveRemote = `git remote rm origin`; 
    
    console.log(`Cloning the repo with name ${repoName}`);
    const checkOut = runCommand(gitCheckoutCommand);
    if( !checkOut ) process.exit(-1);

    process.chdir(`${repoName}`);

    console.log(`Removing remote origin from ${repoName}`);
    const rmRemote = runCommand(gitRemoveRemote);
    if( !rmRemote ) process.exit(-1);
    
    // console.log(`Installing dependencies for ${repoName}`);
    // const installDeps = runCommand(installDepsCommand);
    // if( !installDeps ) process.exit(-1);
    
    console.log(`Congratulations! your project has been installed`);
    
    // console.log(`cd ${repoName} && npm install`);
    
}

module.exports = initialize