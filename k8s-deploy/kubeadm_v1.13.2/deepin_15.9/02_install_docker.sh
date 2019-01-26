#!/bin/bash
# modification based on https://github.com/cookcodeblog/k8s-deploy/blob/master/kubeadm_v1.11.0/02_install_docker.sh

set -e

# Uninstall installed docker
sudo apt-get remove docker docker-engine docker.io containerd runc


# Set up repository
sudo apt-get install apt-transport-https ca-certificates curl python-software-properties software-properties-common

curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/debian/gpg | sudo apt-key add -

# Use Aliyun Docker
sudo add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/debian stretch stable"

# Install docker
# on a new system with yum repo defined, forcing older version and ignoring obsoletes introduced by 17.06.0
sudo apt-get install docker-ce=17.03.3~ce-0~debian-stretch


systemctl enable docker
systemctl start docker

docker version


# Use Aliyun docker registry
./use_aliyun_docker_registry.sh

# 安装指定版本的Docker-CE:
# Step 1: 查找Docker-CE的版本:
# apt-cache madison docker-ce
#   docker-ce | 17.03.1~ce-0~ubuntu-xenial | http://mirrors.aliyun.com/docker-ce/linux/ubuntu xenial/stable amd64 Packages
#   docker-ce | 17.03.0~ce-0~ubuntu-xenial | http://mirrors.aliyun.com/docker-ce/linux/ubuntu xenial/stable amd64 Packages
# Step 2: 安装指定版本的Docker-CE: (VERSION例如上面的17.03.1~ce-0~ubuntu-xenial)
# sudo apt-get -y install docker-ce=[VERSION]