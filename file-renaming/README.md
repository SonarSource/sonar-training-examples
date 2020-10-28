# File renaming

## Use case
This example demonstrates how SonarQube 6.7+ gracefully handles issue tracking and all file history when renaming (and possibly slightly changing) a file, or changing its directory

## Usage

- Run a first analysis (`sonar-scanner`). This will analyze a file named _HelloWorld.java_, class name _HelloWorld_, package name _helloworld_, directory _helloworld_
- The file a has a couple of issues, you may change a few things like severity, comment on some issues
- Run the `./rename.sh` script that transform the above to rename everything as _HelloPlanet_ (including changing the contents of the source for package and class name)
- Run analysis again, preferably with `-Dsonar.projectVersion=2.0` to generate a New Code Period (formerly leak period) and look at the result in SonarQube

## Result
- On SonarQube there are 0 new issues, and existings issues have kept their history of updates (severity change, comments)
- On SonarQube 5.6- the issues are all new, the leak period has plenty of (erroneous) new issues, and the issue changes are lost (the corresponding issues have been closed)

