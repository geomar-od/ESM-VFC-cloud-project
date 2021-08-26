#!/bin/bash

source config.sh

CLUSTER_NODE_POOL_NAMES=(default-pool jupyter-user-pool)

for NODE_POOL_NAME in ${CLUSTER_NODE_POOL_NAMES[@]}; do

  gcloud container clusters resize \
    ${GKE_CLUSTER_NAME} \
    --zone=${GCP_RESOURCE_ZONE} \
    --node-pool ${NODE_POOL_NAME} --num-nodes=1

done
