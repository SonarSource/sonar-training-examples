# File renaming

## Use case
This example demonstrates how SonarQube gracefully handles issue tracking and all file history when renaming (and possibly slightly changing) a file, or changing its directory

## Usage

Run `./analyze.sh` to do the whole sequence in one go, or step through it manually:

- Run a first analysis (`sonar-scanner`). This will analyze a file named _HelloWorld.java_, class name _HelloWorld_, package name _helloworld_, directory _helloworld_
- The file has a couple of issues, you may change a few things like severity, comment on some issues
- Run the `./rename.sh` script that transforms the above to rename everything as _HelloPlanet_ (including changing the contents of the source for package and class name)
- Run analysis again, preferably with `-Dsonar.projectVersion=2.0` to generate a new code period and look at the result in SonarQube

Run `./rename.sh` a second time to rename everything back to _HelloWorld_ and leave the working
tree the way you found it.

## Result
- There are 0 new issues, and existing issues have kept their history of updates (severity change, comments)
- The issues were not closed and re-opened, so none of them shows up as new code
