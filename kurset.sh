#!/bin/bash

kurser_help() {
  echo "
Command: kurset
Usage:
  kurset  --help # Show this help information
  kurset  worker # Build worker nodes
  kurset         # build worker node
  kurset  drain  # delete nodes
  kurset --schedule # build master node and also make it a worker node
  "
  exit 1
}


if [[ $1 = "worker" ]];
then
    ./scripts/worker.sh
elif [[ $1 = "drain" ]];
then
   ./scripts/drain.sh
else
    
    case "$1" in
        --schedule|-s)
            ./scripts/master.sh
            kubectl taint nodes --all node-role.kubernetes.io/master-
            kubectl taint nodes --all  node-role.kubernetes.io/control-plane-
            ;;

          flannel)
            export network=flannel
            ./scripts/master.sh
            ;;
        
        *)
        kurser_help
        ;;
    esac
fi