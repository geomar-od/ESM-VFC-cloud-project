#!/bin/bash

source config.sh

helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo update

helm list --namespace ${K8S_NAMESPACE}

if [[ "$1" == "install" ]]; then

  helm install \
    ${HELM_RELEASE_NAME} jupyterhub/jupyterhub \
    --namespace ${K8S_NAMESPACE} \
    --version ${HELM_CHART_VERSION} \
    --values config.yaml \
    --values secrets.yaml

else

  # Error: UPGRADE FAILED: another operation (install/upgrade/rollback) is in progress
  #
  # Note, if the problem occurs (likely because CTRL-C was hit during deployment) you have to delete the pending release manually.
  # For details see: https://github.com/helm/helm/issues/8987#issuecomment-757644951
  #
  # Steps
  # 1) Execute: kubectl get secret --namespace ${K8S_NAMESPACE}
  # 2) Identify the latest Helm release name: "sh.helm.release.v1.jupyterhub2.v89"
  # 3) Delete Helm release manually: kubectl delete secret sh.helm.release.v1.jupyterhub2.v89 --namespace ${K8S_NAMESPACE} 

  helm upgrade \
    ${HELM_RELEASE_NAME} jupyterhub/jupyterhub \
    --namespace ${K8S_NAMESPACE} \
    --version ${HELM_CHART_VERSION} \
    --values config.yaml \
    --values secrets.yaml \
    --cleanup-on-fail

fi

echo ''; kubectl get service --namespace ${K8S_NAMESPACE}
echo ''; kubectl get nodes --namespace ${K8S_NAMESPACE}
echo ''; kubectl get pods --namespace ${K8S_NAMESPACE}
