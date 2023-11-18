# apex-initializr

This is the list of the main features that I would love to implement in this project.

* ## Generate a standard build artifact

One of the most important goals of this project is to facilitate a seamless deployment process across various environments using DevOps techniques. 

To achieve this, we need to create a standardized artifact that can be installed on different instances of APEX. 

Subsequently, this artifact can be used by CI/CD tools like Jenkins to automate the deployment process.

> I need to confirm the standard format of the artifact that each apex application should have (with all edge cases)

#### <font color="green">status: [ In Progress ] </font>

* ## Figure out a way to integrate an existing project into the APEX initializr

The framework currently works well for new projects that use it as a starting point. However, there are numerous existing projects. Thus, we need to figure out a way to integrate these projects into the APEX initializer.

#### <font color="green">status: [ In Progress ] </font>

* ## Embed LOGGER as the default loggin system

We can't have a big application without a logging system. 
For that purpose, we can use the LOGGER third-party library as the default logger in APEX Initializr. 

> Considering making it optional (enabling or disabling).

* ## Set up a default APEX application for interacting with LOGGER

The idea is to offer an APEX application in case the logger is enabled. This allows the user (developer) to easily utilize LOGGER with a variety of user-friendly reports.


#### <font color="red">status: [ Not Started ] </font>

* ## Use liquibase to manage the application schema

We can use Liquibase to manage the application schema, facilitating the migration process between APEX instances. 
Additionally, it can assist in installing the application in standalone Docker containers for testing purposes.

> Considering making it optional (enabling or disabling).

#### <font color="red">status: [ Not Started ] </font>

* ## Provide the unit testing framework

We can utilize the utPLSQL framework to implement unit testing built into the framework

#### <font color="red">status: [ Not Started ] </font>

* ## Generate the corresponding API for the 'CREATE TABLE' command

The idea here is to provide a default API for any table when generating a table using the command `apex gen-table tableName.` 
We can have more options like `apex gen-table tableName -api` If this optional option is provided, we can then generate the insert, update, and delete procedures directly for this table inside a new package. The package will be created automatically and will contain these three procedures.

example:

    command
        `apex gen-table departments -api`

    results
        new table called `departments`

        new package called `department`

        The `department` will have three procedures: `insertDepartment`, `updateDepartment`, and `deleteDepartment`.

#### <font color="red">status: [ Not Started ] </font>

* ## Provide a global settings system

The idea here is to provide a global settings system to parameterize the application and make some configurations dynamic.

Provide also a plsql API to interact with this settings.

example:

        {
            "ENV_INFO": {
                "TYPE": "DEV|TEST|PROD",
                "HOSTNAME": "oracle.com"
            },
            "ROOT_URL": "${ENV_INFO.HOSTNAME}/ords/",
            "HOME_URL""${ROOT_URL}/home/"
            ...
        }

    call setting

         setting.get('ENV_INFO')

#### <font color="red">status: [ Not Started ] </font>

* ## Develop a dependency management system for PLSQL

The idea is to offer a dependecy management system like npm, maven, gradle...

> I'm not sure yet of the feasibility of this idea !!

example:
    
    instead of installing a third part-library like LOGGER, we can easly add it as dependency and install it directly with 
    a simple command, e.g.: apex install


#### <font color="red">status: [ Not Started ] </font>