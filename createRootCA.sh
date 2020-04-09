#!/usr/bin/env bash
set -e
mkdir "certificate"
openssl genrsa -des3 -out certificate/rootCA.key 2048
openssl req -x509 -new -nodes -key certificate/rootCA.key -sha256 -days 825 -out certificate/rootCA.pem
