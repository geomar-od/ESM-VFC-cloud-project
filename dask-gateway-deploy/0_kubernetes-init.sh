
source config.sh

gcloud container clusters \
  get-credentials ${K8S_NAMESPACE} \
  --zone ${GCP_RESOURCE_ZONE}
