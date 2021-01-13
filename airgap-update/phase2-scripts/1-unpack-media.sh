#!/bin/bash

export PATH=.:$PATH

. ./env

tar -xvzf openshift-client-linux-${OCP_RELEASE}.tar.gz
tar -xvzf openshift-install-linux-${OCP_RELEASE}.tar.gz

