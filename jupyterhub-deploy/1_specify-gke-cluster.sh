#!/bin/bash

source config.sh

if [[ "$1" == "create" ]]; then

  gcloud container clusters create \
    ${GKE_CLUSTER_NAME} --zone ${GCP_RESOURCE_ZONE} \
    --machine-type e2-medium --num-nodes 1

elif [[ "$1" == "update" ]]; then

  # Non-default specifications here.
  # 1) Workload Identity
  # 2) ...

  gcloud container clusters update \
    ${GKE_CLUSTER_NAME} --zone=${GCP_RESOURCE_ZONE} \
    --workload-pool=${GKE_WORKLOAD_POOL}

else

  echo "Nothing to do."

fi
