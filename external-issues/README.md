# External issues

## Prerequisites
- A SonarQube Server instance
- Java, to run the bundled Checkstyle and Detekt jars in [linters](linters)
- Pylint installed (`pip install pylint`, ideally in a virtual environment)
- Golint installed - requires Go, see https://golang.org/dl/, then `go install golang.org/x/lint/golint@latest`

## Use case
This example demonstrates the ability of SonarQube to import issues coming from external analyzers/linters.
SonarQube already provides import capability for the native issue report format of some mainstream linters (eg Pylint and Bandit for Python, Golint and GolangCI-Lint for Go, Detekt for Kotlin etc... non exhaustive list).
When using an analyzer/linter that's not natively supported it's possible to convert the found issue report into a SonarQube generic format (JSON) to import those issues.

The current example demonstrates several cases of external issues import. See the
[external issue documentation](https://docs.sonarsource.com/sonarqube-server/latest/analyzing-source-code/importing-external-issues/external-analyzer-reports/)
for the full list of supported report formats.
- Checkstyle external issues import for Java, via `sonar.java.checkstyle.reportPaths`
- Pylint external issues import for Python, via `sonar.python.pylint.reportPaths`
- Golint external issues import for Go, via `sonar.go.golint.reportPaths`
- Detekt external issues import for Kotlin, via `sonar.kotlin.detekt.reportPaths`
- Custom analyzer external issues import using the [generic issue report format](https://docs.sonarsource.com/sonarqube-server/latest/analyzing-source-code/importing-external-issues/generic-issue-import-format/)

The generic import mimics an imaginary linter (engine id `gdpr-check`) that would scan code related to employee management and detect what is against corporate policy (eg treating employees based on gender, religion...). Admittedly this linter would not detect code **quality** issues, but more **corporate policy violations**. In that respect it would probably not belong in a real world code quality management setup; it is only an example of how to import issues in SonarQube without any particular plugin.

Note that `golint` has been retired by the Go team. It is kept here because it is the only Go
linter that handles this example's loose `.go` files, which are not part of a Go module.

## Usage

1. Run `run-external-linters.sh` to generate the checkstyle, pylint, golint and detekt reports

2. Run the imaginary linter to search for corporate policy violations.
This is actually not executed, we assume that this would produce the [issues.json](issues.json) file that's already in the repository (under the root directory of this project)
You can quickly look at the JSON file structure, it's quite self explanatory.

3. Run `sonar-scanner`, potentially with some specific options like `sonar.token`, url etc...
The [sonar-project.properties](sonar-project.properties) file already has all the settings to import all 5 (checkstyle, pylint, golint, detekt, external issues) reports

4. Check the project in SonarQube and show the external issues (highlight the "linter" tag that's specific to external linters - except for the pylint issues that are not tagged with pylint :-( ).
