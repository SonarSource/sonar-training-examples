# SonarQube Training Examples

Several examples of analysis that demonstrate different use cases.

Each sub-directory is self-contained and has its own README with prerequisites and usage. Most of
them use the shared [sqlib.sh](sqlib.sh) helper, which expects `SONAR_HOST_URL` and `SONAR_TOKEN`
to be set in your environment (it prompts for them otherwise).

## Sub-directories

### Metrics and measures

* [complexity](complexity/): Demonstrates difference between cyclomatic and cognitive complexity

* [coverage-metrics](coverage-metrics/): Demonstrates the calculations for line, condition and overall coverage. Requires Developer Edition for the branches

* [size-metrics](size-metrics/): Demonstrates the calculation of different size metrics (lines, loc, lines to cover, comment lines and comments %)

* [metrics-without-scm](metrics-without-scm/): Demonstrates the ability to compute metrics on new code even without SCM. Requires Enterprise Edition for COBOL

### Branches, pull requests and issue tracking

* [branches](branches/): Demonstrates branch analysis. Requires Developer Edition

* [pull-request](pull-request/): Demonstrates pull request analysis and GitHub decoration. Requires Developer Edition

* [file-renaming](file-renaming/): Demonstrates issue tracking preservation (and new code preservation) in case of file renaming or file move

### Aggregation

* [portfolios](portfolios/): Example of meaningful Portfolios hierarchy and Application. Requires Enterprise Edition

### Security

* [security](security/): Example of Java Vulnerabilities and Security Hotspots, including custom sources, sanitizers and sinks

* [security-cs](security-cs/): The same idea in C#, with a SQL injection introduced as new code

### Languages and toolchains

* [angular](angular/): TypeScript analysis of an Angular application, with Karma/Istanbul coverage import

* [cpp-scan](cpp-scan/): C/C++ analysis with the build wrapper, with a compilation database, and with `clang-tidy` findings imported

### Importing findings from elsewhere

* [external-issues](external-issues/): Example of external linter issues import (Checkstyle, Pylint, golangci-lint, Detekt) and of the generic issue format

### AI

* [ai-code-fix](ai-code-fix/): Small Python files whose issues are good candidates for AI CodeFix suggestions
