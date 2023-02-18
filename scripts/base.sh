#!/bin/bash

sudo apt-get update

$DOCKER_REPO="deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
if ! grep -q "$DOCKER_REPO" /etc/apt/sources.list; then
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository $REPO
fi

sudo apt-get install docker.io
sudo apt-get update && sudo apt-get install -y apt-transport-https curl


sudo tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

sudo tee /etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF


sudo sysctl --system
sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates
sudo apt update
sudo apt install -y containerd.io
sudo /bin/sh -c 'mkdir -p /etc/containerd && containerd config default>/etc/containerd/config.toml'
sudo systemctl restart containerd
sudo systemctl enable containerd

sudo apt-get update && sudo apt-get install -y apt-transport-https curl

$GOOGLE_REPO="deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
if ! grep -q "$GOOGLE_REPO" /etc/apt/sources.list.d/kubernetes.list; then
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
fi


sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl

