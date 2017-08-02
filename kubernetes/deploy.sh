export DIR=${BASH_SOURCE%/*}

if [ "$1" = "delete" ]; then
    echo "Clearing the cluster."
    if [ "$2" = "all" ]; then
        kubectl delete -f ${DIR}/yamls/lego/00-namespace.yml
        kubectl delete -f ${DIR}/yamls/nginx/00-namespace.yml
    fi
    echo "Done. The project was removed from the cluster."
elif [ "$1" = "create" ]; then
    echo "Deploying the project to kubernetes cluster"
    if [ "$2" = "all" ]; then
        # Start KubeLego deployment
        kubectl create -R -f ${DIR}/yamls/lego
        # Start nginx deployment, ingress & service
        kubectl create -R -f ${DIR}/yamls/nginx
    fi
    kubectl create -R -f ${DIR}/yamls/application
    echo "Waiting for server to start up. ~30s."
    sleep 30
    echo "Done. The project was deployed to kubernetes. :)"
fi
