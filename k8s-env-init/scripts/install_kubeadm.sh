K8S_VERSION=${K8S_VERSION-"1.16.0"}

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

yum install --disablerepo=* --enablerepo=base,kubernetes -y kubeadm-$K8S_VERSION kubelet-$K8S_VERSION kubectl-$K8S_VERSION
systemctl enable kubelet
rm -f /etc/yum.repos.d/kubernetes.repo

cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system