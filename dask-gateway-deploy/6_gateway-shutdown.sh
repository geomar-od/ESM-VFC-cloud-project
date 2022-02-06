#!/bin/bash

source config.sh

# Only meaningful for separate Dask gateway deployments.

if [[ ${ALONGSIDE_JUPYTERHUB} == 0 ]]; then

  echo ''; kubectl get nodes -o name --namespace ${K8S_NAMESPACE} | xargs -I {} \
    kubectl drain {} --force --ignore-daemonsets --delete-emptydir-data --grace-period=10

  gcloud container clusters resize \
    ${GKE_CLUSTER_NAME} \
    --zone ${GCP_RESOURCE_ZONE} \
    --node-pool default-pool \
    --num-nodes=0
  
  echo ''; kubectl get pods --namespace ${K8S_NAMESPACE}

fi
