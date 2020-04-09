#!/usr/bin/env bash
set -e
openssl req -new -sha256 -nodes -out certificate/server.csr -newkey rsa:2048 -keyout certificate/server.key -config server.csr.cnf
openssl x509 -req -in certificate/server.csr -CA certificate/rootCA.pem -CAkey certificate/rootCA.key -CAcreateserial -out certificate/server.crt -days 825 -sha256 -extfile v3.ext
