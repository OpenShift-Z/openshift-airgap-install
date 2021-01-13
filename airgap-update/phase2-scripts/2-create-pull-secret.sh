#!/bin/bash

export PATH=.:$PATH

. ./env

# oc registry login only works if there is a valid kube config.
# So, we will fall back to generating raw json instead.
# oc registry login --to ./${LOCAL_SECRET_JSON} --registry "${LOCAL_REGISTRY}" --auth-basic=${LOCAL_REGISTRY_USER}:${LOCAL_REGISTRY_PASSWORD}

REGISTRY_CREDS_B64=$(echo -n "${LOCAL_REGISTRY_USER}:${LOCAL_REGISTRY_PASSWORD}" | base64 -w0)
cat << EOF > ${LOCAL_SECRET_JSON}
{"auths":{"${LOCAL_REGISTRY}":{"auth":"$REGISTRY_CREDS_B64"}}}
EOF
