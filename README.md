# Kurset

## Bootstraping  a k8s cluster with a single command.

### Works  and tested on only ubuntu xeniel  as at now. Error from ./kurset drain could be ignore

### control panel node

On your k8s control panel  server run

`./kurset`

It output a series of commands shown below . Run those. 

  `mkdir -p $HOME/.kube.` 
  
  `sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config. `
  
  `sudo chown $(id -u):$(id -g) $HOME/.kube/config ` 
  
It also output a join command for your worker nodes. Take note of that.

### worker nodes

On your worker nodes run

 `./kurset worker`

Then run the join command from above it looks something like this

  `kubeadm join 152.234.22.33:6443 --token sr4l2l.2kvot0pfalh5o4ik \
    --discovery-token-ca-cert-hash sha256:c692fb047e15883b575bd6710779dc2c5af8073f7cab460abd181fd3ddb29a18 \
    --control-plane `
    
    
   
