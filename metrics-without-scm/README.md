# Metrics without SCM

This example demonstrates metrics on new code without SCM
Particularly useful on COBOL and other legacy languages that are typically not stored in an SCM supported by SonarQube

## Prerequisites
* [SonarQube](http://www.sonarqube.org/downloads/) 7.1

## Usage
* Reset project in initial code state
```
        ./demo.sh reset
```
* Analyze the project with SonarQube using the SonarQube Scanner.
  Even if the code is in git, absence of SCM is emulated by `sonar.scm_enable=false` in `sonar-project.properties`
```
        sonar-scanner
```
* Run the script that will add additional code that's heavily duplicated
  This script will duplicate a copybook creating 1 new bug (nothing new compared to SQ 6.7)
  but also some new lines of code and a high duplication level on new code, therefore failing the QG
  on that latter case (which was missed up to SonarQube 6.7)
```
        ./demo.sh add-code
```
* Re-analyze the code as a new version
```
        sonar-scanner -Dsonar.projectVersion=1.1
```

- On SonarQube **7.0 and below** you'll notice that you have some new __issues__ but no __metrics__ on new code
- On SonarQube **7.1 and and higher** you'll notice that you have some new __issues__ **AND ALSO** __metrics__ on new code

The metric on duplication is particularly interesting, showing a very high duplication level on new code that was invisible in older versions of SonarQube; Note that the overall duplication level is not that impacted

