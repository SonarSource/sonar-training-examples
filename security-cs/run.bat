@echo off
title "this command file mimicks sqlib.sh on Windows systems""
call :separator
echo "both SONAR_HOST_URL:%SONAR_HOST_URL% and SONAR_TOKEN:%SONAR_TOKEN% shall be set"
IF [SONAR_HOST_URL] == [] EXIT
IF [SONAR_TOKEN] == [] EXIT

REM . ../sqlib.sh

set PK=training:security-cs

cd My_API
call :separator
echo "Deleting project %PK%"
curl --silent --output nul --show-error -X POST -u "%SONAR_TOKEN%:" "%SONAR_HOST_URL%/api/projects/delete?project=training:security-cs"
REM Curl for Windows needed (usually gets installed with git)

call :separator
echo "Running initial project scan"
call :doScan

call :separator
echo "Simulating change that introduces vulnerabilities"
cd Controllers
copy ValuesController.cs ValuesController.cs.orig
copy ValuesController.cs.newCode ValuesController.cs 
move ValuesDao.cs.newCode ValuesDao.cs 
cd ..

call :separator
echo Running follow-up project scan
call :doScan
call :separator
echo Restore things as they were
cd Controllers
move ValuesController.cs.orig ValuesController.cs 
move ValuesDao.cs ValuesDao.cs.newCode
cd ../..
goto :eof


:separator
echo ##################################################################
echo ##################################################################

goto :eof

:doScan
  dotnet sonarscanner begin /d:sonar.host.url=%SONAR_HOST_URL% /k:%PK% /n:"C# Security Training Example"  /d:sonar.login=%SONAR_TOKEN%
  dotnet build My_API.sln
  dotnet sonarscanner end /d:sonar.login=%SONAR_TOKEN%
goto :eof
