#!/bin/bash

# Fix up the BASEDIR variable in the service file definition below

mkdir -p ~/.config/systemd/user

echo "Creating the systemd service definition to run the mirror-registry container"
cat <<-"EOF" > ~/.config/systemd/user/mirror-registry.service
[Unit]
Description=mirror registry container in systemd

[Service]
Environment="BASEDIR=/home/ocpadmin/mirror-registry"
Restart=on-failure
ExecStartPre=/usr/bin/rm -f /%t/%n-pid /%t/%n-cid
ExecStart=/usr/bin/podman run --conmon-pidfile /%t/%n-pid --cidfile /%t/%n-cid --name mirror-registry -p 5000:5000 -v ${BASEDIR}/data:/var/lib/registry:z -v ${BASEDIR}/auth:/auth:z -v ${BASEDIR}/certs:/certs:z -e "REGISTRY_AUTH=htpasswd" -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" -e "REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd" -e "REGISTRY_HTTP_TLS_CERTIFICATE=/certs/mirror-registry.crt" -e "REGISTRY_HTTP_TLS_KEY=/certs/mirror-registry.key" -d ibmcom/registry-s390x:2.6.2.5
ExecStop=/usr/bin/sh -c "/usr/bin/podman rm -f `cat /%t/%n-cid`"
KillMode=none
Type=forking
PIDFile=/%t/%n-pid

[Install]
WantedBy=multi-user.target
EOF

echo "Enabling and starting the systemd service"
systemctl --user daemon-reload
systemctl --user enable mirror-registry
systemctl --user start mirror-registry
