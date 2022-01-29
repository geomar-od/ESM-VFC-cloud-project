#!/bin/bash

source config.sh

helm repo add daskgateway https://dask.org/dask-gateway-helm-repo/
helm repo update

helm list --namespace ${K8S_NAMESPACE}

if [[ "$1" == "install" ]]; then

  helm install \
    ${HELM_RELEASE_NAME} daskgateway/dask-gateway \
    --namespace ${K8S_NAMESPACE} \
    --version ${HELM_CHART_VERSION} \
    --values config.yaml \
    --values secrets.yaml

else

  helm upgrade \
    ${HELM_RELEASE_NAME} daskgateway/dask-gateway \
    --namespace ${K8S_NAMESPACE} \
    --version ${HELM_CHART_VERSION} \
    --values config.yaml \
    --values secrets.yaml \
    --cleanup-on-fail

fi

echo ''; kubectl get service --namespace ${K8S_NAMESPACE}
echo ''; kubectl get nodes --namespace ${K8S_NAMESPACE}
echo ''; kubectl get pods --namespace ${K8S_NAMESPACE}
