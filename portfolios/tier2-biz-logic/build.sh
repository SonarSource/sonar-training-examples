# Check-out source code
# git clone https://github.com/SonarSource/sonar-ldap.git
# git pull origin master

# Build code, run tests
# mvn clean org.jacoco:jacoco-maven-plugin:prepare-agent install -Dmaven.test.failure.ignore=true
cd sonar-ldap
mvn clean install

# Run scan
mvn sonar:sonar -Dsonar.host.url=$SQ_URL -Dsonar.login=$TOKEN -Dsonar.projectKey=WEBSITE-TIER2-BIZLOGIC -Dsonar.projectName="Bank Web Site: Tier 2 - Biz Logic"
cd -
