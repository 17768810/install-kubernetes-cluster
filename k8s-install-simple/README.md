# 单节点安装（开发环境）
## 节点规划
``` 
> 1台 master
> 2台 node
```
## 系统环境
1. 操作系统：centos 7.4+
2. 内存：2G+

## 安装步骤
1. 执行 k8s-env-init 内的scripts
2. 使用国内镜像，通常不翻墙失败概率极高
   > 国内安装k8s，需要手动拉取镜像，并设置国内镜像源
   > 1. 获取kubeadm依赖包，其中1.16.2为kubeadm版本
   > 2. kubeadm config images list --kubernetes-version v1.16.2
   ``` 
   > （所有节点都要操作）拉取镜像，镜像源：gcr.azk8s.cn
   
   docker pull gcr.azk8s.cn/google-containers/kube-apiserver:v1.16.2
   docker pull gcr.azk8s.cn/google-containers/kube-controller-manager:v1.16.2
   docker pull gcr.azk8s.cn/google-containers/kube-scheduler:v1.16.2
   docker pull gcr.azk8s.cn/google-containers/kube-proxy:v1.16.2
   docker pull gcr.azk8s.cn/google-containers/pause:3.1
   docker pull gcr.azk8s.cn/google-containers/etcd:3.3.15-0
   docker pull gcr.azk8s.cn/google-containers/coredns:1.6.2

   > （所有节点都要操作）打tag
   
   docker tag gcr.azk8s.cn/google-containers/kube-apiserver:v1.16.2 k8s.gcr.io/kube-apiserver:v1.16.2
   docker tag gcr.azk8s.cn/google-containers/kube-controller-manager:v1.16.2 k8s.gcr.io/kube-controller-manager:v1.16.2
   docker tag gcr.azk8s.cn/google-containers/kube-scheduler:v1.16.2 k8s.gcr.io/kube-scheduler:v1.16.2
   docker tag gcr.azk8s.cn/google-containers/kube-proxy:v1.16.2 k8s.gcr.io/kube-proxy:v1.16.2
   docker tag gcr.azk8s.cn/google-containers/pause:3.1 k8s.gcr.io/pause:3.1
   docker tag gcr.azk8s.cn/google-containers/etcd:3.3.15-0 k8s.gcr.io/etcd:3.3.15-0
   docker tag gcr.azk8s.cn/google-containers/coredns:1.6.2 k8s.gcr.io/coredns:1.6.2
   ```
   ``` 
   > master 初始化，有警告需要自己处理
   
   kubeadm init --kubernetes-version=v1.16.2 --pod-network-cidr=192.168.0.0/16 
   
   > master 按提示执行命令
   mkdir -p $HOME/.kube
   sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
   sudo chown $(id -u):$(id -g) $HOME/.kube/config
   export KUBECONFIG=/etc/kubernetes/admin.conf
   
   > node 节点加入 master
   kubeadm join 172.x.x.x:6443 --token 7r4xl7.nf0tcjri26hnkmcm \
    --discovery-token-ca-cert-hash sha256:261a6311b9f2576c3c5439d28e236526a192a287f0b9be32a097afc01f925f0b
   ```
   ```
   > 运维命令...
   kubectl get nodes
   kubectl get nodes -o wide
   kubectl get pods --all-namespaces
    ```
   > 其他参考
   >> https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/