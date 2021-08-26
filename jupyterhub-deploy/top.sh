#!/bin/bash

source config.sh

#echo ''; gcloud container clusters describe ${GKE_CLUSTER_NAME} --zone=${GCP_RESOURCE_ZONE}

echo ''; kubectl get nodes --namespace ${K8S_NAMESPACE}
echo ''; gcloud container node-pools list --cluster ${GKE_CLUSTER_NAME} --zone ${GCP_RESOURCE_ZONE}

# https://stackoverflow.com/a/48983984
echo ''; kubectl get pod --all-namespaces \
  -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName

echo ''; kubectl top nodes --namespace ${K8S_NAMESPACE}
echo ''; kubectl top pod --namespace ${K8S_NAMESPACE}
