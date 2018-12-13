FROM osixia/openldap

COPY docker/tester.ldif /container/service/slapd/assets/config/bootstrap/ldif/tester.ldif

COPY docker/certs/server.crt /container/service/slapd/assets/certs/my-cert.crt
COPY docker/certs/server.key /container/service/slapd/assets/certs/my-cert.key
COPY docker/certs/ca.crt /container/service/slapd/assets/certs/my-ca.crt
