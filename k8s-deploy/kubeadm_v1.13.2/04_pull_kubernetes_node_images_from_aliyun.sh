#!/bin/bash
# modification based on https://github.com/cookcodeblog/k8s-deploy/blob/master/kubeadm_v1.11.0/04_pull_kubernetes_node_images_from_aliyun.sh

set -e

# Check version in https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-init/
# Search "Running kubeadm without an internet connection"
# For running kubeadm without an internet connection you have to pre-pull the required master images for the version of choice:
KUBE_VERSION=v1.13.2
KUBE_PAUSE_VERSION=3.1
FLANNEL_VERSION=v0.10.0-amd64

GCR_URL=k8s.gcr.io
ALIYUN_URL=registry.cn-hangzhou.aliyuncs.com/jahentao

images=(kube-proxy:${KUBE_VERSION}
pause:${KUBE_PAUSE_VERSION})

docker pull ${ALIYUN_URL}/flannel:${FLANNEL_VERSION}
docker tag ${ALIYUN_URL}/flannel:${FLANNEL_VERSION} quay.io/coreos/flannel:${FLANNEL_VERSION}
docker rmi ${ALIYUN_URL}/flannel:${FLANNEL_VERSION}

for imageName in ${images[@]} ; do
  docker pull $ALIYUN_URL/$imageName
  docker tag  $ALIYUN_URL/$imageName $GCR_URL/$imageName
  docker rmi $ALIYUN_URL/$imageName
done

docker images
