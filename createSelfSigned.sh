#!/usr/bin/env bash

if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Do something under GNU/Linux platform
    openssl req -new -sha256 -nodes -out example/server.csr -newkey rsa:2048 -keyout example/server.key -config server.csr.cnf
    openssl x509 -req -in example/server.csr -CA example/rootCA.pem -CAkey example/rootCA.key -CAcreateserial -out example/server.crt -days 500 -sha256 -extfile v3.ext
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ] || [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    # Do something under 32 bits Windows NT platform
    winpty openssl req -new -sha256 -nodes -out example/server.csr -newkey rsa:2048 -keyout example/server.key -config server.csr.cnf
    winpty openssl x509 -req -in example/server.csr -CA example/rootCA.pem -CAkey example/rootCA.key -CAcreateserial -out example/server.crt -days 500 -sha256 -extfile v3.ext
fi
