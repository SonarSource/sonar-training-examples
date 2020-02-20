# Security example for C#

## Use case
This example demonstrates:
- Vulnerabilities
- Security Hotspots

## Prerequisites
These requirements assume you plan to set up the example from macOS:
- Download and install .NET Core 2.2 or later from: https://dotnet.microsoft.com/download
- Install the dotnet-sonarscanner as a global tool for .NET following the guide here: https://www.nuget.org/packages/dotnet-sonarscanner
- Add dotnet and the global tools install locations to your PATH, e.g. `export PATH=$PATH:/usr/local/share/dotnet:~/.dotnet/tools`
Requirements are the same on Windows, for the batch command file.

## Usage

### macOS
Run `./run.sh`

### Windows
Run `run.bat`

This will:
- Delete the project key **training:security-cs** if it exists in SonarQube (to start from scratch)
- Run an initial build + the sonar scanner for MS Build
- Mimick a change that introduces security vulnerabilities
- Re-run the build to pick up the change as new code

The meat of the project is in the file ValuesController.cs, which introduces the start of a naive web API. The simulated new code change introduces a SQL injection vulnerability.

