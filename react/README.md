# React Example
This example shows how to analyze a React project with SonarQube. The project was generated with [Create Next App](https://nextjs.org/docs/api-reference/create-next-app).

To generate or modify the SonarQube project, execute the command `npm run update-sonar-project`. To view the initial test coverage or update it in the project report, execute the command `npm run test:both:coverage` before running `npm run update-sonar-project`.

## Features
- The project uses [React](https://reactjs.org/) as the UI library to build Single Page Applications;
- The project uses [Next.js](https://nextjs.org/) to build a server-side rendered React application;
- The project uses [TypeScript](https://www.typescriptlang.org/) for type checking;
- The project uses [Jest](https://jestjs.io/) for unit testing;
- The project uses [Cypress](https://www.cypress.io/) for end-to-end testing;
- The project uses [swc-plugin-coverage-instrument](https://github.com/kwonoj/swc-plugin-coverage-instrument) to instrument the code for coverage analysis;
- The project uses [sonarqube-verify](https://github.com/jlmwork/sonarqube-verify) for the fast creating or updating of the SonarQube project.

## Installation
- Install dependencies: `npm install`;
- Create a `.env` file using the `.env.example` file as a template;

## Usage
- To run the application: `npm run dev`, the sever will be available at `http://localhost:3000`;
- To run the unit tests: `npm run tests:unit`;
- To run the end-to-end tests: `npm run tests:e2e`;
- To build the application: `npm run build`;
- To get the coverage results: `npm run test:both:coverage`;
- To create or update the SonarQube project: `npm run update-sonar-project`.
