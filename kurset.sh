#!/bin/bash

if [[ $1 = "worker" ]];
then
    ./scripts/worker.sh
elif [[ $1 = "drain" ]];
then
   ./scripts/drain.sh
else
    export network=$1
    ./scripts/master.sh 
fi