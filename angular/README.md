# AngularSample

This project was generated with [Angular CLI](https://github.com/angular/angular-cli) and modified to be a useful example of scanning such a project with SonarQube.

TypeScript code coverage is assessed using the Istanbul reporter for Karma, configured in the `karma.conf.js` file. In the `build.sh` script, you'll see we run the `ng test` command with the `--code-coverage` parameter to make sure coverage results are captured. All that is needed in addition is to inform the sonar-scanner of the location of the LCOV results file (see the file `sonar-project.properties` for `sonar.javascript.lcov.reportPaths`). 

## Usage

Make sure you have Node.js 10 or higher along with npm available on your PATH. Additionally, the test configuration for this project expects Google Chrome to be installed (modify `karma.conf.js` for other browsers and configurations).

In terms of SonarQube analysis, SonarJS 6.1 and SonarTS 2.1 are required.

Run `build.sh`, which will first use the Angular CLI to run unit tests against the project and then invoke the sonar scanner.

## Development Server

If you're curious to see what this sample app does, run `ng serve` for a dev server. Navigate to `http://localhost:4200/`. The app will automatically reload if you change any of the source files. If the `ng` command is not found, it's probably because you don't have the Angular CLI installed globally. In this case, first run `npm install` and then run `./node_modules/.bin/ng serve`.

## Known Issues

* Using Node.js v14.10.0 can create an infinite loop during node-sass install loop. Downgrade or try an alternative version such as Node.js v12.
