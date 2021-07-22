
source gcp-config.sh

kubectl get nodes --namespace ${K8S_NAMESPACE}
kubectl get pods --namespace ${K8S_NAMESPACE}

gcloud container clusters \
  resize ${GKE_CLUSTER} \
  --zone ${GCP_RESOURCE_ZONE} \
  --num-nodes=1

kubectl get nodes --namespace ${K8S_NAMESPACE}
kubectl get pods --namespace ${K8S_NAMESPACE}

