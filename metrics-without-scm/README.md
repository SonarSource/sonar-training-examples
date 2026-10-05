# Metrics without SCM

This example demonstrates metrics on new code without SCM
Particularly useful on COBOL and other legacy languages that are typically not stored in an SCM supported by SonarQube

## Prerequisites
* A SonarQube Server instance. COBOL analysis requires Enterprise Edition or above.

## Usage
* Reset project in initial code state
```
        ./demo.sh reset
```
* Analyze the project with SonarQube using the SonarQube Scanner.
  Even if the code is in git, absence of SCM is emulated by `sonar.scm.disabled=true` in `sonar-project.properties`
```
        sonar-scanner
```
* Run the script that will add additional code that's heavily duplicated.
  This script copies the `src/custmgt.cbl` program to `src/custmgt.cbl.2.cbl`, uncommenting
  the lines marked `*NEWCODE`. That creates 1 new bug, but also a large number of new lines of
  code and a high duplication level on new code, which is what fails the quality gate
```
        ./demo.sh add-code
```
* Re-analyze the code as a new version
```
        sonar-scanner -Dsonar.projectVersion=1.1
```

You will see new __issues__ **AND ALSO** __metrics__ on new code, even though SonarQube has no SCM
data to tell it which lines are new. Without SCM, SonarQube falls back on comparing the analysis
against the previous one.

The metric on duplication is particularly interesting, showing a very high duplication level on new code; note that the overall duplication level is not that impacted.

Run `./demo.sh reset` when you are done, so the example starts from its initial state next time.
