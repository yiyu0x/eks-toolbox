#!/bin/bash

TMP_DIR="/tmp/eks-toolbox"

install_awscli() {
    echo "installing aws-cli-v2..."
    curl --silent "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "${TMP_DIR}/awscliv2.zip" \
    && unzip -qq "${TMP_DIR}/awscliv2.zip" -d "${TMP_DIR}" \
    && sudo "${TMP_DIR}/aws/install"
}

install_eksctl() {
    echo "installing eksctl..."
    [ ! -d $TMP_DIR/eksctl ] && mkdir $TMP_DIR/eksctl
    curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" \
    | tar xz -C "${TMP_DIR}/eksctl" \
    && sudo cp "${TMP_DIR}/eksctl/eksctl" /usr/local/bin
}

install_kubectl() {
    echo "installing kubectl..."
    [ ! -d $TMP_DIR/kubectl ] && mkdir $TMP_DIR/kubectl
    curl --silent -L "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o "${TMP_DIR}/kubectl/kubectl" \
    && sudo install -o root -g root -m 0755 "${TMP_DIR}/kubectl/kubectl" /usr/local/bin/kubectl
}

install_k9s() {
    echo "installing k9s..."
    [ ! -d $TMP_DIR/k9s ] && mkdir $TMP_DIR/k9s
    curl --silent --location "https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_x86_64.tar.gz" \
    | tar xz -C "${TMP_DIR}/k9s" \
    && sudo cp "${TMP_DIR}/k9s/k9s" /usr/local/bin
}

init() {
    [ ! -d $TMP_DIR ] && mkdir $TMP_DIR
}

clean() {
    rm -rf $TMP_DIR
}

[[ $(uname) != 'Linux' ]] && echo "This script only supports Linux system." && exit 0

init
install_awscli
install_eksctl
install_kubectl
install_k9s
