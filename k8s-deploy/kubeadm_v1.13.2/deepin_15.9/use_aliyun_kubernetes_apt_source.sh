#!/bin/bash

set -e

# https://opsx.alibaba.com/mirror
curl -fsSL http://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | sudo apt-key add -


cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
deb https://mirrors.aliyun.com/kubernetes/apt kubernetes-stretch main
EOF

apt-get clean all
apt-get update
