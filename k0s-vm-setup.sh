#!/bin/bash
# ex: ./k0s-setup-worker.sh k0s-worker1 192.168.0.22

if [ "$(id -u)" != "0" ]; then
   echo "Ce script doit être exécuté avec des privilèges root." 
   exit 1
fi

new_hostname=$1
new_ip=$2

# Delete machine ID
> /etc/machine-id

# Change hostname
hostnamectl set-hostname $new_hostname
sed -i "s/127.0.1.1 .*/127.0.1.1 $new_hostname/" /etc/hosts

# Change static IP
cat > /etc/netplan/00-installer-config.yaml <<EOL
network:
  renderer: networkd
  ethernets:
    enp0s3:
      addresses:
        - $new_ip/24
      nameservers:
        addresses: [4.2.2.2, 8.8.8.8]
      routes:
        - to: default
          via: ${new_ip%.*}.1
  version: 2
EOL
netplan apply

# Configure sshd and reload it
if ! grep -q "^PubkeyAuthentication yes" /etc/ssh/sshd_config; then
    echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
    systemctl restart sshd
fi

# Disable sudo password for user
echo "$(whoami) ALL=(ALL) NOPASSWD:ALL" | (EDITOR="tee -a" visudo)/etc/systemd/system/k0sworker.service