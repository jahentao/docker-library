#!/bin/bash

set -e

# Pre-configure
./01_pre_check_and_configure.sh

# Install Docker
./02_install_docker.sh

# Install kubelet kubeadm kubectl
./03_install_kubernetes.sh

# Pull kubernetes images
./04_pull_kubernetes_images_from_aliyun.sh

# Initialize k8s master
./05_kubeadm_init.sh
# Create a token never expire 
# kubeadm token create --ttl 0
# Generate sha256 hash
# openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //'
# kubeadm join --token <TOKEN> --discovery-token-ca-cert-hash sha256:<SHA256HASH>  <MASTER_IP>:6443 --skip-preflight-checks
# Example:
# kubeadm join --token li3i9j.yyxoyo6eyuozoz91 --discovery-token-ca-cert-hash sha256:49ae818bc61c1fee36e79cf0058197d1501f405d806e591ac58f87bc77ac9133 192.168.237.11:6443

# Install flannel Pod network
./06_install_flannel.sh
