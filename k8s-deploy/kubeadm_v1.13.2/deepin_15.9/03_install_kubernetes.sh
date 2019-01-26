#!/bin/bash

set -e

./use_aliyun_kubernetes_apt_source.sh

apt-get install -y kubelet=1.13.2-00 kubeadm=1.13.2-00 kubectl=1.13.2-00
systemctl enable kubelet && systemctl start kubelet

# Configure cgroup matched with Docker
./configure_cgroup.sh
systemctl daemon-reload
systemctl restart kubelet


# Use Kubernetes default pause image
