# Security

## Use case
This example demonstrates:
- Vulnerabilities
- Security Hotspots

## Usage

Run `./run.sh`

This will:
- Delete the project key **training:security** if it exists in SonarQube (to start from a scratch)
- Run `mvn clean verify sonar:sonar` to re-create the project

Project consists of a single class (training.security.Insecure.java) with a number of Vulnerabilities and Security Hotspots.
