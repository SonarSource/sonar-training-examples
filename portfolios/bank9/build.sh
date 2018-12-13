mvn clean install

# Run scan
mvn sonar:sonar -Dsonar.host.url=$SQ_URL -Dsonar.login=$TOKEN -Dsonar.projectKey=BANK-RETAIL-401K -Dsonar.projectName="Retail Banking - 401K"
