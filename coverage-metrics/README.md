# Coverage Metrics

This example demonstrates:
- The concepts of lines to cover and conditions to cover (different from LoC/Lines)
- The calculation of line, condition and overall coverage.

Additional it shows an example of rule that applies only to test files
The test file contains one UT without any assert statement which is bad practice and raises a violation on a rule which is rule exclusively running on test files

## Usage

- Run `build.sh 1 [<optional_analysis_properties>]` to build and analyze the project with one unit test (UT1) that will give partial coverage
- Run `build.sh 2 [<optional_analysis_properties>]` to build and analyze the project with one unit test (UT2) that will give another partial coverage
- Run `build.sh all [<optional_analysis_properties>]` to build and analyze the project with both UT (UT1 and UT2) that will yield 100% coverage

The `build.sh` script uses different tests files depending on the parameter (1, 2 or both)
and then runs:
```
mvn clean install -P coverage sonar:sonar [<optional_analysis_properties>]
```

## Result
Each different build command will create a project named "Training: Coverage Metrics X" where you can witness the resulting size metrics and coverage information

## Note
Deprecated since 5.12, JaCoCo's binary report format has been dropped with SonarJava analyser 6.0+, and this coverage training has thus been adapted for the newest XML reporting format. Find details with [this community post]
