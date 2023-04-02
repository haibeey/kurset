#!/bin/bash

./scripts/base.sh

sudo apt-get install curl

IP=$(curl ifconfig.me)

echo " ______________________________________________________"
echo "|                                                      |"
echo "|   TAKE THE BELOW COMMAND AND RUN ON WORKER NODES     |"
echo "|   AFTER INITIALIZING THE WORKER  NODE                |"
echo " _______________________________________________________"

sudo kubeadm init --apiserver-advertise-address=$IP --pod-network-cidr=192.168.0.0/16

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# allow ports used by K8S
sudo ufw allow 2379 && sudo ufw allow 2380 && sudo ufw allow 6443 && sudo ufw allow 8090 && sudo ufw allow  8091 && sudo ufw allow 8472 && sudo ufw allow 10250 && sudo ufw allow 10251 && sudo ufw allow  10252 && sudo ufw allow  10255 && sudo ufw allow 179 && sudo ufw allow 4789 && sudo ufw allow 4 && sudo ufw allow  5473 && sudo ufw allow  51820 && sudo ufw allow  51821 && sudo ufw allow 4789


if [[ $network = "flannel" ]];
then
    kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
else
    # using calico at our networking system
    kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/tigera-operator.yaml
    kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/custom-resources.yaml
fi

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.4.0/deploy/static/provider/cloud/deploy.yaml



