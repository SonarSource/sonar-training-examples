# Pull Request

## Use case
This example demonstrates:
- Scanning of a Pull Request
- Pull request decoration on GitHub

## Prerequisites

Pull request analysis requires Developer Edition or above.

For the decoration part, bind the project to GitHub under
**Administration > DevOps Platform Integrations > GitHub** in SonarQube, then set the project's
**Project Settings > General Settings > DevOps Platform Integration** to that configuration. The
old global `sonar.pullrequest.provider`, `sonar.pullrequest.github.*` and `sonar.alm.github.app.*`
properties no longer exist. The GitHub App for this example is `sonarsource-training-examples`
(app id 28687); ask the training team for its private key.

A pull request analysis needs a **pr-demo** branch. It is not in this repository, so create one
locally before you start, for example:

```
git checkout -b pr-demo master
# make a small change that introduces an issue in src/
git commit -am "Introduce an issue for the PR demo"
git checkout master
```

If you push `pr-demo` and open a real pull request on GitHub, you also get the decoration;
otherwise the analysis still shows up under the project's Pull Requests tab.

## Usage

1. Run `./setup.sh`

This will:
- Delete the project key **training:pull-request** if it exists in SonarQube (to start from scratch)
- Check out the master branch
- Run an analysis on master, which becomes the branch the pull request is compared against

2. Create a PR from branch **pr-demo** to **master**. Note the PR key (its number)

3. Run `./scan-pr.sh PR_KEY`

This will:
- Check out the pr-demo branch
- Run a PR analysis of pr-demo against master
- Decorate the PR on GitHub, if the project is bound to GitHub
