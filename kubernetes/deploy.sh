#!/bin/bash
export DIR=${BASH_SOURCE%/*}

if [ "$1" = "delete" ]; then
    echo "Clearing the cluster."
    kubectl delete -f ${DIR}/yamls/nginx
    kubectl delete -f ${DIR}/yamls/echoserver
    kubectl delete -f ${DIR}/yamls/lego
    echo "Done. The project was removed from the cluster."
elif [ "$1" = "create" ]; then
    echo "Deploying the project to kubernetes cluster"
    kubectl create -f ${DIR}/yamls/nginx
    kubectl create -f ${DIR}/yamls/echoserver
    kubectl create -f ${DIR}/yamls/lego
    echo "Done. The project was deployed to kubernetes. :)"
fi
