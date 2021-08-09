
source gcp-config.sh

helm list --namespace ${K8S_NAMESPACE}

helm upgrade \
  ${HELM_RELEASE} jupyterhub/jupyterhub \
  --namespace ${K8S_NAMESPACE} \
  --cleanup-on-fail \
  --version=1.1.1 \
  --values config.yaml

kubectl get pod --namespace ${K8S_NAMESPACE}

