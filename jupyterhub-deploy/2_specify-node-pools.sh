#!/bin/bash

source config.sh

if [[ "$1" == "create" ]]; then

  # gcloud container node-pools create jupyter-user-pool \
  # --cluster=${GKE_CLUSTER_NAME} --zone=${GCP_RESOURCE_ZONE} \
  # --machine-type=e2-standard-8 --num-nodes=1

  gcloud container node-pools create core-pool \
  --cluster=${GKE_CLUSTER_NAME} --zone=${GCP_RESOURCE_ZONE} \
  --machine-type=e2-custom-2-3584 --num-nodes=1

elif [[ "$1" == "configure" ]]; then

  # Enable Google workload identity.

  CLUSTER_NODE_POOL_NAMES=(default-pool jupyter-user-pool)

  for NODE_POOL_NAME in ${CLUSTER_NODE_POOL_NAMES[@]}; do

    gcloud container node-pools update ${NODE_POOL_NAME} \
      --cluster=${GKE_CLUSTER_NAME} --zone=${GCP_RESOURCE_ZONE} \
      --workload-metadata=GKE_METADATA

  done

  # Enable GKE cluster autoscaling.

  gcloud container node-pools update jupyter-user-pool \
    --cluster=${GKE_CLUSTER_NAME} --zone=${GCP_RESOURCE_ZONE} \
    --enable-autoscaling --min-nodes 0 --max-nodes 3

elif [[ "$1" == "delete" ]]; then

  gcloud container node-pools delete jupyter-user-pool \
    --cluster=${GKE_CLUSTER_NAME} --zone=${GCP_RESOURCE_ZONE}

else

  echo "Nothing to do."

fi

kubectl get nodes --show-labels
