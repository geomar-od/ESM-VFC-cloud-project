#!/bin/bash

# gcloud compute machine-types list | head -n 1
# gcloud compute machine-types list | grep europe-west3 # Frankfurt

source config.sh

if [[ "$1" == "create" ]]; then

  gcloud container clusters create \
    ${GKE_CLUSTER_NAME} --zone ${GCP_RESOURCE_ZONE} \
    --machine-type e2-medium --num-nodes 1

elif [[ "$1" == "configure" ]]; then

  # Enable workload identity feature.
  # https://cloud.google.com/kubernetes-engine/docs/how-to/hardening-your-cluster#workload_identity

  gcloud container clusters update \
    ${GKE_CLUSTER_NAME} --zone=${GCP_RESOURCE_ZONE} \
    --workload-pool=${GKE_WORKLOAD_POOL}
  
  # Enable "aggressive" autoscaling profile.
  # https://cloud.google.com/kubernetes-engine/docs/concepts/cluster-autoscaler#autoscaling_profiles

  gcloud container clusters update \
    ${GKE_CLUSTER_NAME} --zone=${GCP_RESOURCE_ZONE} \
    --autoscaling-profile=optimize-utilization

else

  echo "Nothing to do."

fi
