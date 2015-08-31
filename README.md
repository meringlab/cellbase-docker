## Overview
This is a set of docker files for building and running 
[opencb/cellbase](https://github.com/opencb/cellbase).

It takes an hour or so to build and run cellbase manually, 
and this project automates all that. 

Running cellbase includes the following:

 1. checking and compiling the code, 
 2. installing [ensembl-api](http://www.ensembl.org/info/docs/api/api_installation.html), 
 3. perl and a few cpan modules
 4. setting up [mongodb](https://www.mongodb.org/), 
 5. cellbase download task
 6. cellbase build task
 7. cellbase load task
 8. running cellbase server

## How to build 
You'll need [docker](https://www.docker.com/) v1.7 installed. 
Have a look at the make.sh script for required steps.

### Issues Tracking
You can report bugs or request new features at [GitHub issue tracking](https://github.com/meringlab/cellbase-docker/issues).

### Release Notes 
Releases notes are available at [GitHub releases](https://github.com/opencb/cellbase/releases).

### Maintainers

* Milan Simonovic (milan.simonovic@imls.uzh.ch)

##### Contributing
This is an open-source project. I appreciate any help and feeback!
You can contribute in many different ways such as simple bug reporting
and feature requests. Dependending on your skills you are more than
welcome to fix bugs and work on new features, but make sure you pick an
existing issue. 


