
# https://zero-to-jupyterhub.readthedocs.io/en/latest/kubernetes/google/step-zero-gcp.html

source gcp-config.sh

# gcloud compute machine-types list | head -n 1
# gcloud compute machine-types list | grep europe-west3 # Frankfurt

gcloud container clusters create \
  --zone ${GCP_RESOURCE_ZONE} \
  --machine-type e2-standard-2 \
  --num-nodes 1 \
  --cluster-version latest \
  ${GKE_CLUSTER}

