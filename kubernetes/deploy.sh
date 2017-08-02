export DIR=${BASH_SOURCE%/*}

if [ "$1" = "delete" ]; then
    echo "Clearing the cluster."
    if [ "$2" = "all" ]; then
        kubectl delete -f ${DIR}/yamls/lego/00-namespace.yaml
        kubectl delete -f ${DIR}/yamls/nginx/00-namespace.yaml
        kubectl delete -f ${DIR}/yamls/echoserver/00-namespace.yaml
    fi
    echo "Done. The project was removed from the cluster."
elif [ "$1" = "create" ]; then
    echo "Deploying the project to kubernetes cluster"
    if [ "$2" = "all" ]; then
      # echoserver
      kubectl apply -f ${DIR}/yamlsechoserver/00-namespace.yaml
      # kube-lego
      kubectl apply -f ${DIR}/yamls/lego/00-namespace.yaml
      # nginx-ingress
      kubectl apply -f ${DIR}/yamls/nginx/00-namespace.yaml

      kubectl apply -f ${DIR}/yamls/nginx/default-deployment.yaml
      kubectl apply -f ${DIR}/yamls/nginx/default-service.yaml

      kubectl apply -f ${DIR}/yamls/nginx/configmap.yaml
      kubectl apply -f ${DIR}/yamls/nginx/service.yaml
      kubectl apply -f ${DIR}/yamls/nginx/deployment.yaml

      kubectl apply -f ${DIR}/yamls/echoserver/service.yaml
      kubectl apply -f ${DIR}/yamls/echoserver/deployment.yaml
      kubectl apply -f ${DIR}/yamls/echoserver/ingress-notls.yaml

      kubectl apply -f ${DIR}/yamls/lego/configmap.yaml
      kubectl apply -f ${DIR}/yamls/lego/deployment.yaml

      kubectl apply -f ${DIR}/yamls/echoserver/ingress-tls.yaml
      
    fi
    echo "Waiting for server to start up. ~30s."
    sleep 30
    echo "Done. The project was deployed to kubernetes. :)"
fi
