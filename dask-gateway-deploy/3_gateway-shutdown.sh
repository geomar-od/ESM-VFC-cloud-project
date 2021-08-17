
source config.sh

echo ''; kubectl get nodes -o name --namespace ${K8S_NAMESPACE} | xargs -I {} \
  kubectl drain {} --force --ignore-daemonsets --delete-emptydir-data --grace-period=10

gcloud container clusters resize \
  ${GKE_CLUSTER_NAME} \
  --zone ${GCP_RESOURCE_ZONE} \
  --node-pool default-pool \
  --num-nodes=0

gcloud container clusters resize \
  ${GKE_CLUSTER_NAME} \
  --zone ${GCP_RESOURCE_ZONE} \
  --node-pool dask-pool \
  --num-nodes=0

echo ''; kubectl get pods --namespace ${K8S_NAMESPACE}
