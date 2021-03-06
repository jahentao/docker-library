#!/bin/bash

set -e

./use_aliyun_kubernetes_yum_source.sh

yum install -y kubelet-1.13.2 kubeadm-1.13.2 kubectl-1.13.2
systemctl enable kubelet && systemctl start kubelet

# Configure cgroup matched with Docker
./configure_cgroup.sh
systemctl daemon-reload
systemctl restart kubelet


# Use Kubernetes default pause image
