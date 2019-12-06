[ -z "$DOCKER_VERSION" ] || VERSION_SUFFIX="$DOCKER_VERSION"
VERSION_SUFFIX=${VERSION_SUFFIX-"-18.06.2.ce"}
DOCKER_REGISTRY_MIRROR=${DOCKER_REGISTRY_MIRROR-"https://rjvfmwu4.mirror.aliyuncs.com"}

yum install --disablerepo=* --enablerepo=base,updates -y yum-utils \
  device-mapper-persistent-data \
  lvm2

yum-config-manager \
    --add-repo \
    http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

yum install -y docker-ce$VERSION_SUFFIX docker-ce-cli$VERSION_SUFFIX containerd.io
mkdir -p /etc/docker
cat <<EOF > /etc/docker/daemon.json
{
  "registry-mirrors": ["$DOCKER_REGISTRY_MIRROR"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "${DOCKER_LOG_MAX_SIZE:-"200m"}"
  },
  "exec-opts": ["native.cgroupdriver=systemd"],
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.override_kernel_check=true"
  ]
}
EOF
systemctl enable docker --now
systemctl daemon-reload
systemctl restart docker