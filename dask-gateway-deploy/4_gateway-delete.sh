
source config.sh

# Uninstall Helm release.

helm list --namespace ${K8S_NAMESPACE}

helm delete \
  ${HELM_RELEASE_NAME} \
  --namespace ${K8S_NAMESPACE}

helm list --namespace ${K8S_NAMESPACE}

# Delete GKE cluster.

gcloud container clusters delete \
  ${GKE_CLUSTER_NAME} --zone ${GCP_RESOURCE_ZONE}
