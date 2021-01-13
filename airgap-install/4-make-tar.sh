#!/bin/bash

export PATH=.:$PATH

. ./env

WORKDIR="$(pwd)/workdir"

echo "Creating workdir"
mkdir -p ${WORKDIR}

echo "Moving content to workdir"
cp openshift-client-linux-${OCP_RELEASE}.tar.gz ${WORKDIR}
cp openshift-install-linux-${OCP_RELEASE}.tar.gz ${WORKDIR}
cp dry-run.out ${WORKDIR}
cp -a phase2-scripts/* ${WORKDIR}
cp -a portable-media ${WORKDIR}

echo "Making a tar ball"
tar -czf airgap-${OCP_RELEASE}-${ARCHITECTURE}.tgz -C ${WORKDIR} .

echo "Removing workdir"
rm -rf ${WORKDIR}
