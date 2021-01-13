#!/bin/bash

export PATH=.:$PATH

. ./env

#if [[ ${ARCHITECTURE} == "s390x" ]]
#then
#  wget https://mirror.openshift.com/pub/openshift-v4/${ARCHITECTURE}/dependencies/rhcos/4.6/latest/rhcos-live-initramfs.s390x.img
#  wget https://mirror.openshift.com/pub/openshift-v4/${ARCHITECTURE}/dependencies/rhcos/4.6/latest/rhcos-live-kernel-s390x
#  wget https://mirror.openshift.com/pub/openshift-v4/${ARCHITECTURE}/dependencies/rhcos/4.6/latest/rhcos-live-rootfs.s390x.img
#fi

wget https://mirror.openshift.com/pub/openshift-v4/${ARCHITECTURE}/clients/ocp/${OCP_RELEASE}/openshift-client-linux-${OCP_RELEASE}.tar.gz
wget https://mirror.openshift.com/pub/openshift-v4/${ARCHITECTURE}/clients/ocp/${OCP_RELEASE}/openshift-install-linux-${OCP_RELEASE}.tar.gz

tar -xvzf openshift-client-linux-${OCP_RELEASE}.tar.gz
#tar -xvzf openshift-install-linux-${OCP_RELEASE}.tar.gz

REGISTRY_IMAGE_NAME_SHORT=$(echo ${REGISTRY_IMAGE_NAME} | sed "s/ibmcom\///g")
podman pull ${REGISTRY_IMAGE_NAME}
podman tag ${REGISTRY_IMAGE_NAME} ${REGISTRY_IMAGE_NAME_SHORT}
podman save ${REGISTRY_IMAGE_NAME_SHORT} | gzip > registry.tar.gz
cp registry.tar.gz phase2-scripts/extras
