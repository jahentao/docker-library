#!/bin/bash

set -e

ALIYUN_URL=registry.cn-hangzhou.aliyuncs.com/jahentao
FLANNEL_VERSION=v0.10.0-amd64

# Pull flannel images from Aliyun
docker pull ${ALIYUN_URL}/flannel:${FLANNEL_VERSION}
docker tag ${ALIYUN_URL}/flannel:${FLANNEL_VERSION} quay.io/coreos/flannel:${FLANNEL_VERSION}
docker rmi ${ALIYUN_URL}/flannel:${FLANNEL_VERSION}

# this v0.10.0-amd64 kube-flannel.yml is not applied to Kubernetes v1.12 v1.13
# wget https://raw.githubusercontent.com/coreos/flannel/v0.10.0-amd64/Documentation/kube-flannel.yml
# this is an issue https://github.com/coreos/flannel/issues/1044
wget https://raw.githubusercontent.com/coreos/flannel/bc79dd1505b0c8681ece4de4c0d86c5cd2643275/Documentation/kube-flannel.yml
kubectl apply -f kube-flannel.yml

# Wait a while to let network takes effect
sleep 10
kubectl get pods --all-namespaces

# Check component status
kubectl get cs

# Check pods status incase any pods are not in running status
kubectl get pods --all-namespaces | grep -v Running

