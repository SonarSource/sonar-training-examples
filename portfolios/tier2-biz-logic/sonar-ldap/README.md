SonarQube LDAP Plugin
=====================
[![SonarQube Quality Gate status](https://next.sonarqube.com/sonarqube/api/badges/gate?key=org.sonarsource.ldap%3Asonar-ldap-plugin)](https://next.sonarqube.com/sonarqube/overview?id=org.sonarsource.ldap%3Asonar-ldap-plugin)

For more, see [the docs](http://docs.sonarqube.org/display/PLUG/LDAP+Plugin)


## Example

You can check this plugin in action using Docker as described below.

Build plugin:

    mvn clean package

Generate certificates:

    ./docker/gen-certs.sh

Build containers (SonarQube and OpenLDAP servers):

    docker-compose build

Start containers:

    docker-compose up

To access SonarQube use LDAP user `tester` with password `test`.

### License

Copyright 2009-2017 SonarSource.

Licensed under the [GNU Lesser General Public License, Version 3.0](http://www.gnu.org/licenses/lgpl.txt)