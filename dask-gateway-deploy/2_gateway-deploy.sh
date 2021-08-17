
source config.sh

if [[ "$0" == "install" ]]; then

helm upgrade \
  --install ${HELM_RELEASE_NAME} daskgateway/dask-gateway \
  --create-namespace --namespace ${K8S_NAMESPACE} \
  --version ${HELM_CHART_VERSION} \
  --values config.yaml

else

helm upgrade \
  ${HELM_RELEASE_NAME} daskgateway/dask-gateway \
  --namespace ${K8S_NAMESPACE} \
  --version ${HELM_CHART_VERSION} \
  --values config.yaml \
  --cleanup-on-fail

fi

echo ''; kubectl get service --namespace ${K8S_NAMESPACE}
echo ''; kubectl get nodes --namespace ${K8S_NAMESPACE}
echo ''; kubectl get pods --namespace ${K8S_NAMESPACE}
