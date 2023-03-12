export $(cat .env | grep "^SONAR" | xargs)
sonarqube-verify
