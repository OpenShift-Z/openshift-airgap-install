#!/bin/bash

# Create a place for the mirror registry to store images
# Then change the BASEDIR variable to the directory

BASEDIR=/mnt/mirror-registry

# Change the Subject name that will be used in the self-signed cert
# C=country
# O=organization
# CN=the host name of the system where the registry container will run
#
# For example
# SUBJECT="/C=US/O=IBM/CN=registry-host.example.com"
#
# SAN = The DNS resolvable hostname of the server system where the registry container will run
# For example
# SAN="registry-host.example.com"

SUBJECT="/C=US/O=IBM/CN=registry-host.example.com"
SAN="registry-host.example.com"

# Create the directories to hold the mirror registry content
mkdir -p ${BASEDIR}/{auth,certs,data}

# Create a htpasswd based authentication database
htpasswd -bBc htpasswd admin passw0rd
cp htpasswd ${BASEDIR}/auth

# Create a self-signed key pair
openssl req -newkey rsa:4096 -nodes -sha256 -keyout mirror-registry.key -x509 -days 720 -out mirror-registry.crt -subj "${SUBJECT}" -addext "subjectAltName = DNS:${SAN}"

cp mirror-registry.key ${BASEDIR}/certs
cp mirror-registry.crt ${BASEDIR}/certs

sudo cp mirror-registry.crt /etc/pki/ca-trust/source/anchors/
sudo update-ca-trust

