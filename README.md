# apex-initializr

Framework designed for Oracle PL/SQL and/or APEX development projects. This framework offers scripts and processes to accelerate your development and streamline certain aspects of your release procedures

Please take note that this framework is open source. I wholeheartedly welcome any new ideas that can further enhance the growth of this project. If something doesn't align with your project's specific needs or if you require additional modifications, please feel free to make the necessary adjustments and submit a pull request. All the tools provided here are geared towards expediting the delivery of results.

* ## Index

  1. [Index](#index)
  2. [Project Architecture](#project-architecture)
  3. [Project Architecture Details](#project-architecture-details)

* ## Project Architecture

  - bin
    - commands
  - config
    - auto-genertaed
  - scripts
    - automations
    - builds
  - src
    - apex
    - data
    - jobs
    - mviews
    - packages
    - tables
    - triggers
    - view
  - test
    - packages

* ## Project Architecture Details

    | Folder | Description |
    |:--|--|
    | bin | This directory houses the predefined commands utilized within the CLI
    | config | Use YAML files in this folder to make any custom configurations
    | scripts | TBD
    | src | Developers are expected to spend the majority of their time in this directory. It encompasses all the necessary development components (packages, views, tables...)
    | test | This directory is intended for performing necessary testing, including unit tests and automation tests.
