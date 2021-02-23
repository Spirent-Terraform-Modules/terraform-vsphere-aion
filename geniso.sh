#!/bin/bash

if [ "$1" != "" ]; then
  source $1
fi

if [ $TMP_DIR == "" ]; then
    TMP_DIR="./tmp"
fi

mkdir -p $TMP_DIR

cat >${TMP_DIR}/meta-data <<EOL
instance-id: 1
dsmode: local
network-interfaces: |
  iface eth0 inet static
  address $IPV4_ADDR
  netmask $IPV4_NETMASK
  gateway $IPV4_GATEWAY
EOL

cat >${TMP_DIR}/user-data <<EOL
#cloud-config
users:
  - default
  - name: debian
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    ssh_pwauth: True
    ssh_authorized_keys:
      - $SSH_PUBLIC_KEY
EOL
pushd $TMP_DIR


if [ "$ISO" == "" ]; then
  ISO="./cloud-init.iso"
fi
genisoimage  -output $ISO -volid cidata -joliet -rock user-data meta-data
popd

