#!/bin/bash

delete_nodes () {
   for n in $(kubectl get nodes | awk '{if (NR!=1) {print $1}}');
   do
      echo "Deleting node $n"
      kubectl drain $n --ignore-daemonsets --delete-local-data --force --grace-period=0  || true 
      kubectl delete node $n || true
   done
}

delete_nodes || true
sudo kubeadm reset 
sudo apt-get purge kubeadm kubectl kubelet kubernetes-cni kube*    || true
sudo apt-get autoremove   || true
sudo rm -rf ~/.kube || true
sudo ip route flush proto bird || true
sudo ip link list | grep cali | awk '{print $2}' | cut -c 1-15 | xargs -I {} sudo ip link delete {} || true
sudo modprobe -r ipip
sudo rm /etc/cni/net.d/10-calico.conflist || sudo rm /etc/cni/net.d/calico-kubeconfig || true