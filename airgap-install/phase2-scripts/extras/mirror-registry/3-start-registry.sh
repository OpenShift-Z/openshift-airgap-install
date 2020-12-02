#!/bin/bash

# Change the BASEDIR variable to point at the place where you created the directory storage
BASEDIR="/mnt/mirror-registry"

podman run --name mirror-registry -p 5000:5000 \
     --restart=always \
     -v ${BASEDIR}/data:/var/lib/registry:z \
     -v ${BASEDIR}/auth:/auth:z \
     -v ${BASEDIR}/certs:/certs:z \
     -e "REGISTRY_AUTH=htpasswd" \
     -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
     -e "REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd" \
     -e "REGISTRY_HTTP_TLS_CERTIFICATE=/certs/mirror-registry.crt" \
     -e "REGISTRY_HTTP_TLS_KEY=/certs/mirror-registry.key" \
     -d ibmcom/registry-s390x:2.6.2.5
