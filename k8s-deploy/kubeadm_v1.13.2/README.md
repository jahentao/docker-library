<!--  借鉴 https://github.com/cookcodeblog/k8s-deploy/tree/master/kubeadm_v1.11.0 的脚本部署的方式  -->

# 部署说明

脚本适用于CentOS 7。

部署示例：1 Master 2 WORKer

需要替换`MASTER_IP`、`WORK1_IP=192.168.237.12`、`WORK1_IP=192.168.237.13`

Master 节点IP: `MASTER_IP=192.168.237.11`

WORKer 节点IP: `WORK1_IP=192.168.237.12` `WORK2_IP=192.168.237.13`

本脚本部署指定环境：

软件       | 版本                   
--         |--                      
docker-ce  | 17.03.2.ce-1.el7.centos
kubeadm    | 1.13.2
kubectl    | 1.13.2
kubelet    | 1.13.2




## clone 代码

1. git clone

2. svn checkout （备用）

主要是本仓库除了部署脚本，还有很多Dockerfile文件，只需要 k8s-deploy 文件夹。[参考][1]
```bash
yum install -y svn

# 通用的办法是将”/branches/branchname/”替换成”/trunk/”
SVNURL=https://github.com/jahentao/docker-library/trunk/k8s-deploy/kubeadm_v1.13.2
svn checkout $SVNURL
```

![svn-github-checkout](https://images-markdown.oss-cn-hangzhou.aliyuncs.com/configure/docker/svn-github.png)

## Master 节点 `MASTER_IP`

```bash
cd kubeadm_v1.13.2
chmod +x *.sh

# 检查配置系统、安装Docker、安装Kubernetes、拉取镜像、安装集群、安装Flannel
./kubeadm_init_master.sh

```
一些系统设置可能已经设置好，会中断脚本，若不幸中断，需要自己修改/操作，完成脚本。

需要记录`kubeadm init`的token

样例如：
```bash
kubeadm join 192.168.237.11:6443 --token mvp9oi.b1azhgrtk1iistwx --discovery-token-ca-cert-hash sha256:4d33679b0428289c5516253736497469a90ba34d1d4aa6f16e1672c19c9e9995
```


## WORK 节点 `WORK1_IP` `WORK2_IP`

```bash
cd kubeadm_v1.13.2
chmod +x *.sh

# 检查配置系统、安装Docker、安装Kubernetes、拉取镜像
./kubeadm_join_node.sh
```

将节点加入集群

```bash
kubeadm join 192.168.237.11:6443 --token mvp9oi.b1azhgrtk1iistwx --discovery-token-ca-cert-hash sha256:4d33679b0428289c5516253736497469a90ba34d1d4aa6f16e1672c19c9e9995
```





[1]: https://blog.csdn.net/u012104219/article/details/79057489 "教你在Github下载仓库子文件夹"
