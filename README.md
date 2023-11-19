# apex-initializr

Framework designed for Oracle PLSQL and/or APEX development projects. This framework offers scripts and processes to accelerate your development and streamline certain aspects of your release procedures

I truly welcome any new ideas that can further enhance the growth of this project. 

If something doesn't align with your project's specific needs or if you require additional modifications, please feel free to make the necessary adjustments and submit a **pull request**. 

All the tools provided here are geared towards accelerating the delivery of applications.

* ## Index

  1. [Index](#index)
  2. [Requirements](#requirements)
  3. [Project Architecture](#project-architecture)
  4. [Project Architecture Details](#project-architecture-details)

* ## Requirements

  * node >= v20.9.0 & npm >= 10.2.3
  * You must have the database connection string
  * It's preferred to work with Git. If not, you should make some changes (required changes [TBD])
  * You must have SQLPLUS and SQLCL installed
  
* ## Project Architecture

  - `bin`
  - `config`
    - `config-files`
      - `paths.yml`  <font color="red">This file should not be altered or moved from its current path</font>
      - `project-config.yml`
      - `user-config.yml`
    - `scripts`
    - `templates`
  - `scripts`
    - `automations`
    - `builds`
    - `tasks`
  - `src`
    - `apex`
    - `data`
    - `jobs`
    - `mviews`
    - `packages`
    - `tables`
    - `triggers`
    - `view`
  - `test`
    - `packages`

* ## Project Architecture Details

    This section provides a concise overview of each root folder in the project. Feel free to add or remove folders to align with your project's specific needs.
    For documentation related to subfolders not listed here, please refer to the **README** file within the respective folder.

    **NOTE**
  
    One of the standout features of **APEX Initializr** is its **Dynamic Architecture**, allowing you to modify any file or directory in the project seamlessly.

    This is made possible through the global paths declared in the `paths.yml` file (**!!be careful not to change the path of this file!!**).

    We've implemented this functionality to cater to the diverse needs of developers.

    | Folder | Description |
    |:--|--|
    | bin | This directory contains the predefined commands utilized within the CLI
    | config | Use YAML files in this folder to make any custom configurations
    | scripts | TBD
    | src | Developers are expected to spend the majority of their time in this directory. It encompasses all the necessary development components (packages, views, tables...)
    | test | This directory is intended for performing necessary testing, including unit tests and automation tests...
