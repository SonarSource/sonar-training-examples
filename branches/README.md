# Branches

## Use case
This example demonstrates [branch analysis](https://docs.sonarsource.com/sonarqube-server/latest/analyzing-source-code/branch-analysis/introduction/):
how several branches of one project live side by side in SonarQube, each with its own issues,
measures and new code.

## Prerequisites

Branch analysis requires Developer Edition or above.

## Usage

Run `./analyze-branches.sh`

This will:
- Delete the project key **training:branches** if it exists in SonarQube (to start from scratch)
- Create a project named **Training: Branches** with a main branch
- Add a branch named `release-1.1` in which some new bugs were injected
- Add a `feature-X` branch off the main branch and a `hotfix-for-release` branch off `release-1.1`,
  each with new issues compared to the branch it came from

Note that SonarQube no longer distinguishes short-lived from long-lived branches, and the old
`sonar.branch` parameter was removed. Every branch is analyzed with `sonar.branch.name`.

## TODO
- Mark an issue from the main branch as FP, and show that this is reported on all the other branches (feature and release-1.1)
- Display scanner commands on stdout to make it clearer for readers
