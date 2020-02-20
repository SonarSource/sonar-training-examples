@echo off
title "this command file mimicks sqlib.sh on Windows systems""
call :separator
echo "both SQ_URL:%SQ_URL% and SQ_TOKEN:%SQ_TOKEN% shall be set"
IF [SQ_URL] == [] EXIT
IF [SQ_TOKEN] == [] EXIT

REM . ../sqlib.sh

set PK=training:security-cs

cd My_API
call :separator
echo "Deleting project %PK%"
curl --silent --output nul --show-error -X POST -u "%SQ_TOKEN%:" "%SQ_URL%/api/projects/delete?project=training:security-cs"
REM Curl for Windows needed (usually gets installed with git)

call :separator
echo "Running initial project scan"
call :doScan

call :separator
echo "Simulating change that introduces vulnerabilities"
cd Controllers
cp ValuesController.cs ValuesController.cs.orig
cp ValuesController.cs.newCode ValuesController.cs 
mv ValuesDao.cs.newCode ValuesDao.cs 
cd ..

call :separator
echo Running follow-up project scan
call :doScan
call :separator
echo Restore things as they were
cd Controllers
mv ValuesController.cs.orig ValuesController.cs 
mv ValuesDao.cs ValuesDao.cs.newCode
cd ../..
goto :eof


:separator
echo ##################################################################
echo ##################################################################

goto :eof

:doScan
  dotnet sonarscanner begin /d:sonar.host.url=%SQ_URL% /k:%PK% /n:"C# Security Training Example"  /d:sonar.login=%SQ_TOKEN%
  dotnet build My_API.sln
  dotnet sonarscanner end /d:sonar.login=%SQ_TOKEN%
goto :eof
