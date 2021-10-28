# Coverage Metrics

This example demonstrates:
- The concepts of lines to cover and conditions to cover (different from LoC/Lines)
- The calculation of line, condition and overall coverage.
- Some rules/issues on test files

## Usage

- Run `build.sh` to build and analyze 3 different branches of the projects: `master`, `partial-coverage`, `partial-coverage-2` and `issue-on-test-files`

## Result
- This creates a project in SonarQube called *Training: Coverage*
- Each branch of the project has a different coverage due to a different set of tests
  - `master` has 2 tests (test1 and test2) that yield 100% coverage
  - `partial-coverage` branch has 1 test (test1) that yields 85.7% coverage
  - `partial-coverage-2` branch has 1 test (test2) that yields 71.4% coverage
  - `issue-on-tests-files` is a branch to show SonarQube rules specific for tests. It shows an issue on a test file that's improperly written
