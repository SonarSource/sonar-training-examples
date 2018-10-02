# Check-out source code
git clone https://github.com/SonarSource/sonar-ldap.git
git pull origin master

# Build code, run tests
# mvn clean org.jacoco:jacoco-maven-plugin:prepare-agent install -Dmaven.test.failure.ignore=true
mvn clean install

# Run scan
mvn sonar:sonar
