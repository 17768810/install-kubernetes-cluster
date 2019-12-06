export DOCKER_VERSION='-18.06.2.ce'
export K8S_VERSION='1.16.0'

CURRENT_DIR=$(cd $(dirname $0); pwd)

$CURRENT_DIR/k8s_basic_env_init.sh
$CURRENT_DIR/install_docker.sh
$CURRENT_DIR/install_kubeadm.sh