# apex-initializr

This is the list of the main features that I would love to implement in this project.

* ## Generate a standard build artifact

One of the most important goals of this project is to facilitate a seamless deployment process across various environments using DevOps techniques. 

To achieve this, we need to create a standardized artifact that can be installed on different instances of APEX. 

Subsequently, this artifact can be used by CI/CD tools like Jenkins to automate the deployment process.

#### status: [ In Progress ] 

* ## Embed LOGGER as the default loggin system

We can't have a big application without a logging system. 
For that purpose, we can use the LOGGER third-party library as the default logger in APEX Initializr. 

!! Thinking of making it optional (enable or disable) !!

#### status: [ Not Started ] 

* ## Use liquibase to manage the application schema

We can use Liquibase to manage the application schema, facilitating the migration process between APEX instances. 
Additionally, it can assist in installing the application in standalone Docker containers for testing purposes.

!! Thinking of making it optional (enable or disable) !!

* ## Generate the corresponding API for the 'CREATE TABLE' command

