# External issues

## Prerequisites
- A SonarQube Server instance
- Java, to run the bundled Checkstyle and Detekt jars in [linters](linters)
- Pylint installed (`pip install pylint`, ideally in a virtual environment)
- golangci-lint installed, see https://golangci-lint.run/welcome/install/ (`brew install golangci-lint` on macOS)

`run-external-linters.sh` checks for all three up front and stops with an explanatory message if
one is missing, rather than leaving an empty report that the scan would silently import as nothing.

## Use case
This example demonstrates the ability of SonarQube to import issues coming from external analyzers/linters.
SonarQube already provides import capability for the native issue report format of some mainstream linters (eg Pylint and Bandit for Python, Golint and GolangCI-Lint for Go, Detekt for Kotlin etc... non exhaustive list).
When using an analyzer/linter that's not natively supported it's possible to convert the found issue report into a SonarQube generic format (JSON) to import those issues.

The current example demonstrates several cases of external issues import. See the
[external issue documentation](https://docs.sonarsource.com/sonarqube-server/latest/analyzing-source-code/importing-external-issues/external-analyzer-reports/)
for the full list of supported report formats.
- Checkstyle external issues import for Java, via `sonar.java.checkstyle.reportPaths`
- Pylint external issues import for Python, via `sonar.python.pylint.reportPaths`
- GolangCI-Lint external issues import for Go, via `sonar.go.golangci-lint.reportPaths`
- Detekt external issues import for Kotlin, via `sonar.kotlin.detekt.reportPaths`
- Custom analyzer external issues import using the [generic issue report format](https://docs.sonarsource.com/sonarqube-server/latest/analyzing-source-code/importing-external-issues/generic-issue-import-format/)

The generic import mimics an imaginary linter (engine id `gdpr-check`) that would scan code related to employee management and detect what is against corporate policy (eg treating employees based on gender, religion...). Admittedly this linter would not detect code **quality** issues, but more **corporate policy violations**. In that respect it would probably not belong in a real world code quality management setup; it is only an example of how to import issues in SonarQube without any particular plugin.

### A note on the Go side of this example

This demo used to run `golint`, which the Go team has since retired. It now runs golangci-lint,
which took two small pieces of scaffolding to make work on this particular source tree:

- **[go.mod](go.mod)** — golangci-lint only analyzes code that belongs to a module. The module is
  declared at the project root so that the file paths in the report are relative to
  `sonar.projectBaseDir`, which is what the scanner needs in order to match them to files.
- **One file at a time.** Every file in [src/go](src/go) is a standalone `package main` with its
  own `main()`, so the directory as a whole does not typecheck and golangci-lint would report
  nothing but `main redeclared in this block`. The script therefore lints each file separately
  and stitches the per-file checkstyle documents into one report. This is a quirk of this
  example's layout, not something you would do on a real project.

[.golangci.yml](.golangci.yml) enables the standard linter set plus `revive`, the maintained
successor to golint, which keeps the `var-naming` findings this demo used to show.

## Usage

1. Run `run-external-linters.sh` to generate the checkstyle, pylint, golangci-lint and detekt reports

2. Run the imaginary linter to search for corporate policy violations.
This is actually not executed, we assume that this would produce the [issues.json](issues.json) file that's already in the repository (under the root directory of this project)
You can quickly look at the JSON file structure, it's quite self explanatory.

3. Run `sonar-scanner`, potentially with some specific options like `sonar.token`, url etc...
The [sonar-project.properties](sonar-project.properties) file already has all the settings to import all 5 (checkstyle, pylint, golangci-lint, detekt, external issues) reports

Expect roughly 286 external issues, which the Issues page can be filtered down per engine:
`external_checkstyle` 14, `external_pylint` 251, `external_golangci-lint` 15, `external_govet` 1
(golangci-lint reports `govet` findings under their own engine id), `external_detekt` 3 and
`external_gdpr-check` 2.

4. Check the project in SonarQube and show the external issues (highlight the "linter" tag that's specific to external linters - except for the pylint issues that are not tagged with pylint :-( ).
