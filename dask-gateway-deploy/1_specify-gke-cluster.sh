
source config.sh

# Separate Dask gateway cluster.

if [[ ${ALONGSIDE_JUPYTERHUB} == 0 ]]; then

  # https://serverfault.com/questions/822787/create-google-container-engine-cluster-without-default-node-pool
  # "You cannot do this using gcloud or the cloud console, but you can achieve what you are trying to do if you use the raw GKE API."

  if [[ "$1" == "create" ]]; then

    gcloud container clusters create \
      ${GKE_CLUSTER_NAME} --zone ${GCP_RESOURCE_ZONE} \
      --machine-type e2-medium --num-nodes 1
    # machine type could be smaller/custom!

  elif [[ "$1" == "configure" ]]; then

    # Enable workload identity feature.
    # https://cloud.google.com/kubernetes-engine/docs/how-to/hardening-your-cluster#workload_identity

    gcloud container clusters update \
      ${GKE_CLUSTER_NAME} --zone=${GCP_RESOURCE_ZONE} \
      --workload-pool=${GKE_WORKLOAD_POOL}
    
    # Enable "aggressive" autoscaling profile.
    # https://cloud.google.com/kubernetes-engine/docs/concepts/cluster-autoscaler#autoscaling_profiles

    #gcloud container clusters update \
    #  ${GKE_CLUSTER_NAME} --zone=${GCP_RESOURCE_ZONE} \
    #  --autoscaling-profile=optimize-utilization

  else

    echo "Nothing to do."

  fi

fi