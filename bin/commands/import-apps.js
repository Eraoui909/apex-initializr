#!/usr/bin/env node

const {runCommand} = require('./helper')

function importApps(ids){


    runCommand(`sh scripts/tasks/import-app.sh ${ids.appId}`)

}

module.exports = importApps;