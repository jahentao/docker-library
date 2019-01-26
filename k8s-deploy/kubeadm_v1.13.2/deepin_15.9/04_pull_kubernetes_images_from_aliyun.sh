#!/bin/bash
# modification based on https://github.com/cookcodeblog/k8s-deploy/blob/master/kubeadm_v1.10.3/04_pull_kubernetes_images_from_aliyun.sh

set -e

# Check version in https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-init/
# Search "Running kubeadm without an internet connection"
# For running kubeadm without an internet connection you have to pre-pull the required master images for the version of choice:

# Can `kubeadm config images pull` see the need images
KUBE_VERSION=v1.13.2
KUBE_PAUSE_VERSION=3.1
ETCD_VERSION=3.2.24
COREDNS_VERSION=1.2.6

GCR_URL=k8s.gcr.io
ALIYUN_URL=registry.cn-hangzhou.aliyuncs.com/jahentao

# When test v1.13.2, I found Kubernetes depends on both pause-amd64:3.1 and pause:3.1

images=(kube-proxy:${KUBE_VERSION}
kube-scheduler:${KUBE_VERSION}
kube-controller-manager:${KUBE_VERSION}
kube-apiserver:${KUBE_VERSION}
pause:${KUBE_PAUSE_VERSION}
etcd:${ETCD_VERSION}
coredns:${COREDNS_VERSION})


for imageName in ${images[@]} ; do
  docker pull $ALIYUN_URL/$imageName
  docker tag  $ALIYUN_URL/$imageName $GCR_URL/$imageName
  docker rmi $ALIYUN_URL/$imageName
done

# docker rmi $(docker images -f dangling=true)

docker images
