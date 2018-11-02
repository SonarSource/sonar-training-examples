# Pull Request

## Use case
This example demonstrates:
- Scanning of a Pull Request
- Decoration of Pull Request on GitHub

## Usage

Before running make sure tthere is no open pull request on GitHub.com for branch
**pr-demo** (close if there is) and the following properties are set on your
SonarQube instance:

| Property                              | Value                   |
| --------------------------------------|-------------------------|
| sonar.pullrequest.provider            | GitHub                  |
| sonar.pullrequest.github.endpoint     | https://api.github.com/ |
| sonar.pullrequest.github.token.secured| YOUR_GITHUB_AUTH_TOKEN  |

1. Run `./setup.sh`

This will:
- Delete the project key **training:pull-request** if it exists in SonarQube (to start from a scratch)
- Checkout the master branch from GitHub
- Run an analysis on the master

2.  Create a PR on GitHub.com existing branch **pr-demo** to **master** .  Note the PR key

1. Run `./scan-pr.sh PR_KEY`
- Checkout the pr-demo branch from GitHub
- Run a PR analysis on the pr-demo branch
- Trigger PR decoration on GitHub
