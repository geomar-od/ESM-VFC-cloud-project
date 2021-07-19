
NAMESPACE=jupyterhub-k8s-1

helm list --namespace ${NAMESPACE}

helm upgrade \
  --cleanup-on-fail \
  --namespace ${NAMESPACE} \
  jupyterhub-hr-1 jupyterhub/jupyterhub \
  --version=1.0.1 \
  --values config.yaml

kubectl get pod --namespace ${NAMESPACE}
