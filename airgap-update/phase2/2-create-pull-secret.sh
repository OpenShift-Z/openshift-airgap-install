#!/bin/bash

export PATH=.:$PATH

. ./env

oc registry login --to ./${LOCAL_SECRET_JSON} --registry "${LOCAL_REGISTRY}" --auth-basic=${LOCAL_REGISTRY_USER}:${LOCAL_REGISTRY_PASSWORD}

cat ${LOCAL_SECRET_JSON} | tr -d "[:space:]" > ${LOCAL_SECRET_JSON}.nowhitespace
