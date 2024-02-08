#!/bin/bash

# Usage: ./clear-ssh.sh <k0s-config.yaml>

# Verify if a file name is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

filename=$1

# Extract IP for "address:" et "externalAddress:"
ips=$(grep -E "address:|externalAddress:" $filename | awk '{ print $2 }')

# clear IPs
for ip in $ips
do
    echo "Suppression de la clé pour $ip"
    ssh-keygen -R "$ip"
done
