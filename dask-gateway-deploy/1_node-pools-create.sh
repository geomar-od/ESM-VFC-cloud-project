
source config.sh

echo ''; gcloud container node-pools list --cluster=${GKE_CLUSTER_NAME} --zone=${GCP_RESOURCE_ZONE}
echo ''; kubectl get nodes --namespace ${K8S_NAMESPACE}

# 8 vCPU 32 GB

gcloud container node-pools create \
  dask-pool \
  --zone=${GCP_RESOURCE_ZONE} \
  --cluster=${GKE_CLUSTER_NAME} \
  --machine-type=e2-standard-8 \ 
  --preemptible --num-nodes=1

echo ''; gcloud container node-pools list --cluster ${GKE_CLUSTER_NAME} --zone ${GCP_RESOURCE_ZONE}
echo ''; kubectl get nodes --namespace ${K8S_NAMESPACE}

# Migration tasks

# https://cloud.google.com/kubernetes-engine/docs/tutorials/migrating-node-pool
#for node in $(kubectl get nodes -l cloud.google.com/gke-nodepool=default-pool -o=name); do
#  kubectl drain --force --ignore-daemonsets --delete-local-data --grace-period=10 "$node";
#done

# kubectl get nodes -o name --namespace ${K8S_NAMESPACE} | xargs -I {} \
#   kubectl drain {} --force --ignore-daemonsets --delete-emptydir-data --grace-period=10

# kubectl get nodes -o name --namespace ${K8S_NAMESPACE} | xargs -I {} \
#   kubectl uncordon {}
