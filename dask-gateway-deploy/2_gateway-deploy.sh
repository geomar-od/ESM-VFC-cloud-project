
source config.sh

helm list --namespace ${K8S_NAMESPACE}

if [[ "$1" == "install_create_namespace" ]]; then

helm install \
  ${HELM_RELEASE_NAME} daskgateway/dask-gateway \
  --create-namespace --namespace ${K8S_NAMESPACE} \
  --version ${HELM_CHART_VERSION} \
  --values config.yaml \
  --values secrets.yaml

elif [[ "$1" == "install_into_namespace" ]]; then

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
  --cleanup-on-fail \
  --values config.yaml \
  --values secrets.yaml

fi

echo ''; kubectl get service --namespace ${K8S_NAMESPACE}
echo ''; kubectl get nodes --namespace ${K8S_NAMESPACE}
echo ''; kubectl get pods --namespace ${K8S_NAMESPACE}
