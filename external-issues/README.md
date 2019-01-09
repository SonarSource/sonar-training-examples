# External issues

## Use case
This example demonstrates the ability of SonarQube 7.2+ to import issues coming from external analyzers/linters
SonarQube already provides  import capability for the native issue report format of some mainstream linters (eg Pylint for Python, Golint, GoMetaLinter for Go, Detekt for Kotlin etc... non exhaustive list)
When using an analyzer/linter that's not natively supported it's prossible to convert the found issue report into a SonarQube generic format (JSON) to import those issues

The current example mimics a imaginary linter (employer-fairness) that would scan code related to employee management and detect what is
against corporate policy (eg treat employees based on gender, religion...). Admittedly this linter would not detect code **quality** issues, but more **corporate policy violations**. To this respect it would probably not belong in a real world for code quaity maangement, it is only an example of how to import issues in SonarQube without any particular plugin.

## Usage

0. Run the imaginary linter to search for corporate policy violations.
This is actually not executed, we assume that this would produce the [issues.json](issues.json) file that's already in the repository (under the root directory of this project)
You can quickly look at the JSON file structure, it's quite self explanatory. More details on the format at [https://docs.sonarqube.org/latest/analysis/generic-issue/]

1. Run `sonar-scanner`, potentially with some specific options like sonar.login, url etc...
The [sonar-project.properties](sonar-project.properties) file already has the setting `sonar.externalIssuesReportPaths=issues.json` set to parse the file

2.  Check the project in SonarQube and show the external issues (highlight the "linter" tag that's specific to external linters).
