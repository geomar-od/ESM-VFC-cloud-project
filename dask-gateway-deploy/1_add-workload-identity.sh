
source config.sh

# Currently, the only accepted workload pool is the workload pool
# of the billing cloud project: PROJECT_ID.svc.id.goog

GKE_WORKLOAD_POOL=${GCP_BILLING_PROJECT}.svc.id.goog

# Update Kubernetes cluster and Kubernetes cluster node pools.

gcloud container clusters update \
  ${GKE_CLUSTER_NAME} \
  --zone=${GCP_RESOURCE_ZONE} \
  --workload-pool=${GKE_WORKLOAD_POOL}

CLUSTER_NODEPOOL_NAME=default-pool

gcloud container node-pools update \
  ${CLUSTER_NODEPOOL_NAME} \
  --cluster=${GKE_CLUSTER_NAME} \
  --zone=${GCP_RESOURCE_ZONE} \
  --workload-metadata=GKE_METADATA

CLUSTER_NODEPOOL_NAME=dask-pool

gcloud container node-pools update \
  ${CLUSTER_NODEPOOL_NAME} \
  --cluster=${GKE_CLUSTER_NAME} \
  --zone=${GCP_RESOURCE_ZONE} \
  --workload-metadata=GKE_METADATA

# Create and annotate Kubernetes service account.

kubectl create serviceaccount \
  --namespace ${K8S_NAMESPACE} \
  ${IAM_SERVICE_ACCOUNT_NAME_PREFIX}

kubectl annotate serviceaccount \
  --namespace ${K8S_NAMESPACE} \
  ${IAM_SERVICE_ACCOUNT_NAME_PREFIX} \
  iam.gke.io/gcp-service-account=${IAM_SERVICE_ACCOUNT_NAME}

# Bind Kubernetes service account to an existing IAM service account.

gcloud iam service-accounts add-iam-policy-binding \
  --member "serviceAccount:${GKE_WORKLOAD_POOL}[${K8S_NAMESPACE}/${IAM_SERVICE_ACCOUNT_NAME_PREFIX}]" \
  --role roles/iam.workloadIdentityUser \
  ${IAM_SERVICE_ACCOUNT_NAME}
