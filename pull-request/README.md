# Pull Request

## Use case
This example demonstrates:
- Scanning of a Pull Request
- Addition of a Status Check to Pull Request on GitHub

## Usage

Before running, make sure there is no open pull request on GitHub.com for branch
**pr-demo** (close if there is) and the following properties are set on your
SonarQube instance:

| Property                                | Value                         |
| ----------------------------------------|-------------------------------|
| sonar.pullrequest.provider              | GitHub                        |
| sonar.pullrequest.github.endpoint       | https://api.github.com/       |
| sonar.alm.github.app.name               | sonarsource-training-examples |
| sonar.alm.github.app.id                 | 28687                         |
| sonar.alm.github.app.privateKey.secured | Retrieve value from https://drive.google.com/file/d/17g5in0_BiL6zwiOYQCBnG3vCDFGJHaKX/view?usp=sharing    |

1. Run `./setup.sh`

This will:
- Delete the project key **training:pull-request** if it exists in SonarQube (to start from a scratch)
- Checkout the master branch from GitHub
- Run an analysis on the master

2.  Create a PR on GitHub.com existing branch **pr-demo** to **master** .  Note the PR key

3. Run `./scan-pr.sh PR_KEY`

This will:
- Checkout the pr-demo branch from GitHub
- Run a PR analysis on the pr-demo branch
- Set Status Check on PR on GitHub
