#!/bin/bash

source config.sh

if [[ "$1" == "create" ]]; then

  gcloud container node-pools create jupyter-user-pool \
  --cluster=${GKE_CLUSTER_NAME} --zone=${GCP_RESOURCE_ZONE} \
  --machine-type=e2-standard-8 --num-nodes=1

  # gcloud container node-pools create dask-worker-pool \
  # --cluster=${GKE_CLUSTER_NAME} --zone=${GCP_RESOURCE_ZONE} \
  # --machine-type=e2-standard-8 --preemptible --num-nodes=1

elif [[ "$1" == "update" ]]; then

  # Enable Google workload identity features.

  CLUSTER_NODE_POOL_NAMES=(default-pool jupyter-user-pool dask-worker-pool)

  for NODE_POOL_NAME in ${CLUSTER_NODE_POOL_NAMES[@]}; do

    gcloud container node-pools update ${NODE_POOL_NAME} \
      --cluster=${GKE_CLUSTER_NAME} --zone=${GCP_RESOURCE_ZONE} \
      --workload-metadata=GKE_METADATA

  done

  # Enable autoscaling feature here.

elif [[ "$1" == "delete" ]]; then

  echo "Nothing to do."

  # gcloud container node-pools delete dask-worker-pool \
  #   --cluster=${GKE_CLUSTER_NAME} --zone=${GCP_RESOURCE_ZONE}

else

  echo "Nothing to do."

fi
