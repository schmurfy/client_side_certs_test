#!/bin/sh

NAME=test.local

mkdir -p server
mkdir -p clients

echo "Generating self-sugned private key..."
openssl genrsa -des3 -out server/$NAME.key 2048

echo "Stripping passphrase..."
cp server/$NAME.key server/$NAME.key.original
openssl rsa -in server/$NAME.key.original -out server/$NAME.key
rm server/$NAME.key.original


echo "Generating CSR..."
openssl req -new -key server/$NAME.key -out server/$NAME.csr


echo "Generating Certificate..."
openssl x509 -req -days 365 -in server/$NAME.csr -signkey server/$NAME.key -out server/$NAME.crt
