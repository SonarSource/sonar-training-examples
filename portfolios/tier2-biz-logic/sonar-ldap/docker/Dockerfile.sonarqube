FROM sonarqube:lts-alpine

COPY docker/sonar.properties /opt/sonarqube/conf/sonar.properties
COPY sonar-ldap-plugin/target/sonar-ldap-plugin-*-SNAPSHOT.jar /opt/sonarqube/extensions/plugins/

COPY docker/certs/ca.crt /root/ca.crt
COPY docker/certs/client.p12 /root/client.p12

RUN keytool -import -trustcacerts -alias my-ca -file /root/ca.crt -keystore /etc/ssl/certs/java/cacerts -storepass changeit -noprompt

RUN keytool -importkeystore \
        -deststorepass changeit -destkeypass changeit -destkeystore /root/keystore \
        -srckeystore /root/client.p12 -srcstoretype PKCS12 -srcstorepass pass

RUN keytool -list -v -keystore /root/keystore -storepass changeit
