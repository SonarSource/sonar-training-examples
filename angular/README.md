# Sonar Angular Example

This project was originally generated with [Angular CLI](https://github.com/angular/angular-cli) version 17.0.1.

Install `npm` to install dependencies: `npm install`. Make sure you have Node.js 20 or higher along with npm available on your PATH. Additionally, the test configuration for this project expects Google Chrome to be installed (modify `karma.conf.js` for other browsers and configurations).

## Sonar Scanning and Code Coverage

TypeScript code coverage is assessed using the Istanbul reporter for Karma, configured in the `karma.conf.js` file. In the `build.sh` script, you'll see we run the `ng test` command with the `--code-coverage` parameter to make sure coverage results are captured. All that is needed in addition is to inform the sonar-scanner of the location of the LCOV results file (see the file `sonar-project.properties` for `sonar.javascript.lcov.reportPaths`).

Run `build.sh`, which will first use the Angular CLI to run unit tests against the project and then invoke the sonar scanner.

## Development server

Run `ng serve` for a dev server. Navigate to `http://localhost:4200/`. The application will automatically reload if you change any of the source files.

## Code scaffolding

Run `ng generate component component-name` to generate a new component. You can also use `ng generate directive|pipe|service|class|guard|interface|enum|module`.

## Build

Run `ng build` to build the project. The build artifacts will be stored in the `dist/` directory.

## Running unit tests

Run `ng test` to execute the unit tests via [Karma](https://karma-runner.github.io).

## Running end-to-end tests

Run `ng e2e` to execute the end-to-end tests via a platform of your choice. To use this command, you need to first add a package that implements end-to-end testing capabilities.

## Further help

To get more help on the Angular CLI use `ng help` or go check out the [Angular CLI Overview and Command Reference](https://angular.io/cli) page.

## Updating Angular version
You can also find the most current version of Angular by using the CLI command `ng update`. By default, `ng update`(without additional arguments) lists the updates that are available to you.
