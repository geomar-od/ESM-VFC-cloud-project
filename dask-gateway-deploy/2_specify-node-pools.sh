#!/bin/bash

source config.sh

echo ''; gcloud container node-pools list --cluster=${GKE_CLUSTER_NAME} --zone=${GCP_RESOURCE_ZONE}
echo ''; kubectl get nodes --namespace ${K8S_NAMESPACE}

if [[ "$1" == "create" ]]; then

  # e2-standard-8 machine types takes 7 single CPU Dask workers!
  gcloud container node-pools create dask-worker-pool \
  --cluster=${GKE_CLUSTER_NAME} --zone=${GCP_RESOURCE_ZONE} \
  --machine-type=e2-standard-8 --preemptible --num-nodes=0

elif [[ "$1" == "configure" ]]; then

  # Enable Google workload identity.

  gcloud container node-pools update dask-worker-pool \
   --cluster=${GKE_CLUSTER_NAME} --zone=${GCP_RESOURCE_ZONE} \
   --workload-metadata=GKE_METADATA

  # Enable GKE autoscaling. Choose aggressive autoscaling.
  # https://cloud.google.com/kubernetes-engine/docs/concepts/cluster-autoscaler#autoscaling_profiles

  gcloud container node-pools update dask-worker-pool \
   --cluster=${GKE_CLUSTER_NAME} --zone=${GCP_RESOURCE_ZONE} \
   --enable-autoscaling \
   --autoscaling-profile optimize-utilization
  
  gcloud container node-pools update dask-worker-pool \
    --cluster=${GKE_CLUSTER_NAME} --zone=${GCP_RESOURCE_ZONE} \
    --min-nodes 0 --max-nodes 60

elif [[ "$1" == "delete" ]]; then

  gcloud container node-pools delete dask-worker-pool \
    --cluster=${GKE_CLUSTER_NAME} --zone=${GCP_RESOURCE_ZONE}

else

  echo "Nothing to do."

fi

echo ''; gcloud container node-pools list --cluster=${GKE_CLUSTER_NAME} --zone=${GCP_RESOURCE_ZONE}
echo ''; kubectl get nodes --namespace ${K8S_NAMESPACE}
