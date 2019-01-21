# External issues

## Prerequisites
- SonarQube 7.2+
- Pylint installed (normally comes standard with the pre-installed python on most OS)
- Golint installed - Requires installation of Go Language, see https://golang.org/dl/

## Use case
This example demonstrates the ability of **SonarQube 7.2+** to import issues coming from external analyzers/linters
SonarQube already provides  import capability for the native issue report format of some mainstream linters (eg Pylint and Bandit for Python, Golint, GoMetaLinter for Go, Detekt for Kotlin etc... non exhaustive list)
When using an analyzer/linter that's not natively supported it's prossible to convert the found issue report into a SonarQube generic format (JSON) to import those issues

The current example demonstrates several cases of external issues import
- Checkstyle external issues import for Java (without need for checkstyle plugin). See https://docs.sonarqube.org/display/PLUG/Importing+SpotBugs%2C+FindSecBugs%2C+PMD%2C+Checkstyle+Issues+Reports
- Pylint external issues import for Python (without need for checkstyle plugin). See https://docs.sonarqube.org/display/PLUG/Import+Pylint+Issues+Report
- Golint external issues import for Go, natively available with teh SonarGo plugin. See https://docs.sonarqube.org/display/PLUG/Importing+GoVet%2C+GoLint+and+GoMetaLinter+Issues+Reports
- Detekt external issues import for Kotlin, natively available with the Kotlin plugin. https://docs.sonarqube.org/display/PLUG/Import+AndroidLint+and+Detekt+Issues+Reports

- Customer analyser external issues import using the generic issue report format. See https://docs.sonarqube.org/latest/analysis/generic-issue/

It mimics a imaginary linter (employer-fairness) that would scan code related to employee management and detect what is against corporate policy (eg treat employees based on gender, religion...). Admittedly this linter would not detect code **quality** issues, but more **corporate policy violations**. To this respect it would probably not belong in a real world for code quaity maangement, it is only an example of how to import issues in SonarQube without any particular plugin.

## Usage

1. Run `run-external-linters.sh` to generate the checkstyle, pylint, golint and detekt reports

2. Run the imaginary linter to search for corporate policy violations.
This is actually not executed, we assume that this would produce the [issues.json](issues.json) file that's already in the repository (under the root directory of this project)
You can quickly look at the JSON file structure, it's quite self explanatory. More details on the format at https://docs.sonarqube.org/latest/analysis/generic-issue/

3. Run `sonar-scanner`, potentially with some specific options like sonar.login, url etc...
The [sonar-project.properties](sonar-project.properties) file already has all the settings to import all 5 (checkstyle, pylint, golint, detekt, external issues) report

4.  Check the project in SonarQube and show the external issues (highlight the "linter" tag that's specific to external linters - except for the pylint issues that are not tagged with pylint :-( ).
