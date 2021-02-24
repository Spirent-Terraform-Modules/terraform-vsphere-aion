#!/bin/bash

SYNTAX="syntax: import_spec.sh [network]"

if [ "$1" == "" ]; then
   >&2 echo "error: Invalid syntax."
   >&2 echo "$SYNTAX"
   exit 1
fi

NET=$1

read -d '' SPEC << EOF
{
    "DiskProvisioning": "flat",
    "IPProtocol": "IPv4",
    "InjectOvfEnv": false,
    "MarkAsTemplate": true,
    "Name": null,
    "NetworkMapping": [
        {
            "Name": "bridged",
            "Network": "$NET"
        }
    ],
    "PowerOn": false,
    "WaitForIP": false
}
EOF
echo "$SPEC"
