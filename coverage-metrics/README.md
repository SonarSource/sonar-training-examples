# Coverage Metrics

This example demonstrates:
- The concepts of lines to cover and conditions to cover (different from LoC/Lines)
- The calculation of line, condition and overall coverage.
- Some rules/issues on test files

## Prerequisites

Analyzing the non-main branches requires Developer Edition or above.

## Usage

- Run `build.sh` to build and analyze 6 branches of the project: `master`, `partial-coverage`,
  `partial-coverage-2`, `issue-on-test-files`, `mixed-languages` and `2-branches-4-conditions`

The script checks out each branch in this repository in turn, and returns to the branch you
started from when it is done. Commit or stash your work before running it.

## Result
- This creates a project in SonarQube called *Training: Coverage* (key `training:coverage`)
- Each branch of the project has a different coverage due to a different set of tests
  - `master` has 3 tests (test1, test2 and test3). test1 and test2 together yield 100% coverage
  - `partial-coverage` branch has 1 test (test1) that yields 85.7% coverage
  - `partial-coverage-2` branch has 1 test (test2) that yields 71.4% coverage
  - `issue-on-test-files` is a branch to show SonarQube rules specific for tests. It keeps only
    test3, which calls the method under test but never asserts on the result, so SonarQube raises
    an issue for the missing assertion
  - `2-branches-4-conditions` adds a second parameter and a loop, so the method has 4 conditions
    to cover instead of 2
  - `mixed-languages` shows the metrics across both the Java and the JavaScript sources
