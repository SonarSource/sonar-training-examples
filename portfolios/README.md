# Portfolios and Applications

This example demonstrates the concepts of portfolios and applications using projects with meaningful names so that they "speak" better to the trainee

## Prerequisites

Portfolios and applications require Enterprise Edition or above. The three `tier*` projects
also analyze several branches, which requires Developer Edition or above.

## Usage

- Run `./scanAllProjects.sh` to create all the projects in SonarQube (this can be skipped once projects have been analyzed at least once).
  Each project's own `build.sh` scans it and tags it with `superbank.com`, and the script logs
  the output of each build into `<project>/build.log`

- Run `./create-portfolios.sh`.
This will create, from the description provided in file **portfolios-def.txt**:
   - A meaningful hierarchy of portfolios
   - An application that recombines the 3 tiers of a web application

- Portfolios are recomputed automatically after the projects they contain are analyzed. To force a
  refresh immediately, use **Administration > Portfolios > Recompute** in SonarQube

The helper script `tagAllProjects.sh` re-applies the `superbank.com` tag to every project, which
is useful if you want to demonstrate tag-based portfolio selection without re-scanning.

If needed you can also use the `delete-portfolios.sh` script that will remove all portfolios and applications created by the `create-portfolios.sh` script
