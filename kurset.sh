#!/bin/bash

if [[ $1 = "worker" ]];
then
    ./scripts/worker.sh
else
    ./scripts/master.sh 
fi