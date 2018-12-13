#!/bin/bash

set -e

cd docker
mkdir certs
cd certs

openssl genrsa -out ca.key 4096
openssl req -x509 -new -nodes -key ca.key -days 9131 -out ca.crt -subj "/C=CH/ST=Geneva/L=Geneva/O=Example/CN=example.org"

openssl genrsa -out server.key 4096
openssl req -new -key server.key -out server.csr -subj "/C=CH/ST=Geneva/L=Geneva/O=Example/CN=ldap-server"
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 9131

openssl genrsa -out client.key 4096
openssl req -new -key client.key -out client.csr -subj "/C=CH/ST=Geneva/L=Geneva/O=Example/CN=sonarqube-server"
openssl x509 -req -in client.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out client.crt -days 9131

cat client.crt ca.crt > cert-chain.txt
openssl pkcs12 -export -inkey client.key -in cert-chain.txt -out client.p12 -password pass:pass
rm cert-chain.txt
