#!/bin/bash

kurser_help() {
  echo "
Command: kurset
Usage:
  kurset  --help # Show this help information
  kurset  worker # Build worker nodes
  kurset         # build worker node
  kurset --schedule # build master node and also make it a worker node
  "
  exit 1
}


if [[ $1 = "worker" ]];
then
    ./scripts/worker.sh
else
    ./scripts/master.sh
    case "$1" in
        --schedule|-s)
            kubectl taint nodes --all node-role.kubernetes.io/master-
            kubectl taint nodes --all  node-role.kubernetes.io/control-plane-
            ;;
        *)
        kurser_help
        ;;
    esac
fi