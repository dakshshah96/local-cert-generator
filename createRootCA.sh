#!/usr/bin/env bash

## manual at https://www.freecodecamp.org/news/how-to-get-https-working-on-your-local-development-environment-in-5-minutes-7af615770eec/

## original from https://github.com/dakshshah96/local-cert-generator/
# openssl genrsa -out rootCA.key 2048
# openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 5000 -out rootCA.pem;

if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Do something under GNU/Linux platform
    openssl genrsa -out certs/rootCA.key 2048
    openssl req -x509 -new -nodes -key certs/rootCA.key -sha256 -days 5000 -out certs/rootCA.pem -subj "/C=DE/ST=Random/L=Random/O=Random/OU=Random/CN=Local Certificate";
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ] || [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    # Do something under 32 bits Windows NT platform
    winpty openssl genrsa -out certs/rootCA.key 2048
    winpty openssl req -x509 -new -nodes -key certs/rootCA.key -sha256 -days 5000 -out certs/rootCA.pem -subj "//C=DE\ST=Random\L=Random\O=Random\OU=Random\CN=Local Certificate";
fi
