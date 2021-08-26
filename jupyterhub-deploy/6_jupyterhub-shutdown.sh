#!/bin/bash

source config.sh

echo ''; kubectl get nodes -o name --namespace ${K8S_NAMESPACE} | xargs -I {} \
  kubectl drain {} --force --ignore-daemonsets --delete-emptydir-data --grace-period=10

# Specify nodes to scale down.

CLUSTER_NODE_POOL_NAMES=(default-pool jupyter-user-pool)

for NODE_POOL_NAME in ${CLUSTER_NODE_POOL_NAMES[@]}; do

  gcloud container clusters resize \
    ${GKE_CLUSTER_NAME} \
    --zone=${GCP_RESOURCE_ZONE} \
    --node-pool ${NODE_POOL_NAME} --num-nodes=0

done

echo ''; kubectl get pods --namespace ${K8S_NAMESPACE}
