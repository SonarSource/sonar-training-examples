# C++ Scan

## Use case
This example demonstrates:
- How to use the build wrapper, to wrap the usual build command regardless of what this command is
- How to use external compilation databases instead of the build wrapper generated files

## Usage
- Build normally the project with the command
`./build.sh`
- Explain that, for SonarQube analysis, this command must be wrapped with build-wrapper. So run again `build-wrapper --out-dir bw-output ./build.sh`
  - See note about the download-build-wrapper.sh script below and adapt the command line accordingly
- Show briefly the generated directory `bw-output`
- Run `sonar-scanner -Dsonar.cfamily.build-wrapper-output=bw-output` to run the analysis.
Explain that the `sonar.cfamily.build-wrapper-output` property must point at the same directory provided to build wrapper

## New / Experimental - Use compilation database
Whenever you are in a situation where you cannot use the build-wrapper (unsupported compiler, OS, ...) you may use the workaround of compilation databases.
If you can produce a compilation database in the [Clang JSON format](https://clang.llvm.org/docs/JSONCompilationDatabase.html) you may analyze code without running the build wrapper. This directory gives an example:
- Install the python `compiledb`tool
`pip3 install compiledb`
- Run in on a command that builds the code, this generates the **compile_commands.json** file
`compiledb make -B`
- Convert **compile_commands.json** into build wrapper output format with the script provided in this example.
`python3 convert-compile-commands.py compile_commands.json`
- Run the scanner

Even better, some compilation (make, cmake) can generate the compilation DB without actually compiling the code, and this is obviously much faster. So you may even analyze C++ code without compiling it. Example: `make -n -B` emulates compilation but does not actually compiles. So you may run `compiledb make -n -B` to generate the compilation DB without even compiling


## Things to remember:
- **build wrapper** can "wrap" any build command. For instance
     - This C++ project can also be built with make (command `make -f makefile`) and can equally be wrapped this way (`build-wrapper --out-dir bw-output make -f makefile`)
     - If the project is a Objective-C project the command to wrap would be xcodebuild, (example `build-wrapper --out-dir bw-output xcodebuild`, see [XCodebuild example](../objc-scan-with-coverage))
     - If the project would be a VisualC++ project you would run `build-wrapper --out-dir bw-output MSBuild.exe /t:rebuild`
- For projects with a mix of languages, **build wrapper** must be used as soon as there is a single line of C, C++ or Objective-C
- **build wrapper** can only be run once in the build. If your project is built through different build steps, you must wrap a top command that will build the whole project (all the build steps or at least all steps that build C, C++ or Objective-C)
- **build wrapper** is downloadable from SonarQube, as soon as the SonarCFamily plugin is installed (URL is <SONARQUBE_ROOT_URL>/static/cpp/build-wrapper-<os>.zip)
- **build wrapper** is redelivered with each SonarCFamily plugin so it's good practice to re download build wrapper each time you update the SonarCFamily plugin.
This can even be done automatically each time you analyze. See the `download-build-wrapper.sh` script
