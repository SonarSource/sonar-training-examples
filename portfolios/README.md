# Portfolios and Applications

This example demonstrates the concepts and portfolios using projects with meaningful name so that they "speak" better to the trainee

## Usage

- Run `./scanAllProjects.sh` to create all the projects in SonarQube (this can be skipped once projects have been analyzed at least once)

- Run `./create-portfolios.sh`. 
This will create, from the description provided in file **portfolios-def.txt**,:
   - A meaningful hierarchy of portfolios 
   - An application that recombines the 3 tiers of a web application

- To compute the portfolios
   - For SonarQube 6.x: run `sonar-scanner views`
   - For SonarQube 7.x:, re-run `./scanAllProjects.sh`

If needed you can also use the `delete-portfolios.sh` script that will remove all portfolios and applications created by the `create-portfolios.sh` script 
