# Branches

## Use case
This example demonstrates:
- [Branches](https://docs.sonarqube.org/latest/branches/overview/) in general
- Difference between short lived branches and long lived branches
- Difference of SQ 5.6 _old-style_ branches and SQ 6.7 _new-style_ branches

## Usage

Run `./analyze-branches.sh`

This will:
- Delete the project key **training:branches** if it exists in SonarQube (to start from a scratch)
- Create a project with name **Training: Branches** with a master branch
- One long lived branch name release-1.1 when some new bugs were injected
- 2 short lived branches, one feature branch on **master** and one hotfix on **release-1.1**, each of them with new issues compared to their target branches

You can also run `./analyze-branches.sh sonar.branch` to run the same branches analysis with the old branch system to show the difference. This will create 4 different projects,
one for each branch, without any visibility of the delta between branches.
To not conflict with the new style branches projects the project key is **training:branches-old-style**, and project name is **Training: Branches (old-style)**

## TODO
- Mark an issue from master as FP, and show that this is reported on all the other branches (feature and release-1.1)
- Display scanner commands on stdout to make it clearer for readers

