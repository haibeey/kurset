#!/bin/bash

./scripts/base.sh

# expose ports used by k8s
sudo ufw allow 2379 && sudo ufw allow 2380 && sudo ufw allow 6443 && sudo ufw allow 8090 && sudo ufw allow  8091 && sudo ufw allow 8472 && sudo ufw allow 10250 && sudo ufw allow 10251 && sudo ufw allow  10252 && sudo ufw allow  10255 && sudo ufw allow 179 && sudo ufw allow 4789 && sudo ufw allow 4 && sudo ufw allow  5473 && sudo ufw allow  51820 && sudo ufw allow  51821 && sudo ufw allow 4789
