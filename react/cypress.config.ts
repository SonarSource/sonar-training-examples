import { defineConfig } from 'cypress'

const baseUrl = 'http://localhost:3000';
const collectCoverage = 'CYPRESS_COVERAGE' in process.env;

export default defineConfig({
	video: false,
	...(collectCoverage ? {
		reporter: 'cypress-sonarqube-reporter',
		reporterOptions: {
			overwrite: true,
			outputDir: 'coverage/cypress/reports',
			useAbsoluteSpecPath: true,
			preserveSpecsDir: false,
			mergeOutputDir: 'coverage/cypress',
			mergeFileName: 'sonarqube-report.xml'
		},
	} : {}),
	env: {
		codeCoverage: {
			exclude: ['cypress/**/*.*', 'node_modules/**/*.*']
		}
	},
	e2e: {
		baseUrl,
		setupNodeEvents(on, config) {
			if (collectCoverage) {
				require('@cypress/code-coverage/task')(on, config);

				on('after:run', (results) => {
					return require('cypress-sonarqube-reporter/mergeReports')(results);
				});
			}
			return config;
		}
	}
})
