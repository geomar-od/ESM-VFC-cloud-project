
source config.sh

echo ''; kubectl get nodes --namespace ${K8S_NAMESPACE}
echo ''; kubectl get pods --namespace ${K8S_NAMESPACE}

# gcloud container clusters resize \
#   ${GKE_CLUSTER_NAME} \
#   --zone ${GCP_RESOURCE_ZONE} \
#   --node-pool default-pool \
#   --num-nodes=1

# echo ''; kubectl get nodes --namespace ${K8S_NAMESPACE}
# echo ''; kubectl get pods --namespace ${K8S_NAMESPACE}

gcloud container clusters resize \
  ${GKE_CLUSTER_NAME} \
  --zone ${GCP_RESOURCE_ZONE} \
  --node-pool dask-worker-pool \
  --num-nodes=1

echo ''; kubectl get nodes --namespace ${K8S_NAMESPACE}
echo ''; kubectl get pods --namespace ${K8S_NAMESPACE}
