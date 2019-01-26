#!/bin/bash

set -e

# Reset firstly if ran kubeadm init before
kubeadm reset -f

# kubeadm init with flannel network
kubeadm init --kubernetes-version=v1.13.2 --pod-network-cidr=10.244.0.0/16

# Record
# kubeadm join 192.168.1.200:6443 --token 3fnw76.f1uq6ej7qqfnc8k7 --discovery-token-ca-cert-hash sha256:af11748b614e09043e8618adb203242554f79931578a05f5eabd99dc7b3c35c1

mkdir -p $HOME/.kube
sudo cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
cp -p $HOME/.bash_profile $HOME/.bash_profile.bak$(date '+%Y%m%d%H%M%S')
echo "export KUBECONFIG=$HOME/.kube/config" >> $HOME/.bash_profile
source $HOME/.bash_profile


