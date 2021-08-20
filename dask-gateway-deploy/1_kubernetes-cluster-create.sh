
source config.sh

# Dask gateway default node pool.

# https://serverfault.com/questions/822787/create-google-container-engine-cluster-without-default-node-pool
# "You cannot do this using gcloud or the cloud console, but you can achieve what you are trying to do if you use the raw GKE API."

gcloud container clusters create \
  ${GKE_CLUSTER_NAME} \
  --zone ${GCP_RESOURCE_ZONE} \
  --machine-type e2-medium \
  --num-nodes 1 \
  --cluster-version latest
