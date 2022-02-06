#!/bin/bash

source config.sh

# https://github.com/jupyterhub/zero-to-jupyterhub-k8s/issues/1934
# https://kubesphere.io/docs/cluster-administration/shut-down-and-restart-cluster-gracefully/
# https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node/
# https://kubernetes.io/blog/2021/04/21/graceful-node-shutdown-beta/

# Specify node pools to scale down.

CLUSTER_NODE_POOL_NAMES=(default-pool jupyter-user-pool)
CLUSTER_NODE_POOL_NAMES=(default-pool)

for NODE_POOL_NAME in ${CLUSTER_NODE_POOL_NAMES[@]}; do

  echo ''; kubectl get nodes -o name --namespace ${K8S_NAMESPACE} | grep ${NODE_POOL_NAME} | xargs -I {} \
    kubectl drain {} --force --ignore-daemonsets --delete-emptydir-data --grace-period=10

  gcloud container clusters resize \
    ${GKE_CLUSTER_NAME} \
    --zone=${GCP_RESOURCE_ZONE} \
    --node-pool ${NODE_POOL_NAME} --num-nodes=0

done

echo ''; kubectl get pods --namespace ${K8S_NAMESPACE}

# kubectl uncordon node/gke-jupyterhub2-default-pool-e8a18768-5zfd
