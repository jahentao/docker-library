#!/bin/bash

set -e

echo "###############################################"
echo "Please ensure your OS is CentOS7 64 bits"
echo "Please ensure your machine has full network connection and internet access"
echo "Please ensure run this script with root user"

# Check hostname, Mac addr and product_uuid
echo "###############################################"
echo "Please check hostname as below:"
uname -a

echo "###############################################"
echo "Please check Mac addr and product_uuid as below:"
ip link
sudo cat /sys/class/dmi/id/product_uuid

# Turn off Swap
echo "###############################################"
echo "Turn off Swap"
swapoff -a
cp -p /etc/fstab /etc/fstab.bak$(date '+%Y%m%d%H%M%S')
sed -i "s/\/swapfile/\#\/swapfile/g" /etc/fstab
mount -a
free -m
cat /proc/swaps

# Setup iptables (routing)
echo "###############################################"
echo "Setup iptables (routing)"
cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-arptables = 1
EOF

sysctl --system

# Upadate Time 
apt install -y ntpdate
ntpdate cn.pool.ntp.org
# `crontab -e`  input
# 0-59/10 * * * * /usr/sbin/ntpdate us.pool.ntp.org | logger -t NTP


