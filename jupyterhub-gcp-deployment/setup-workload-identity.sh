
source gcp-config.sh

# References
# ----------
# https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity

# Describe state.

gcloud container clusters describe ${GKE_CLUSTER} --zone=${GCP_RESOURCE_ZONE}

# Currently, the only accepted workload pool is the workload pool of
# the cloud project containing the cluster: PROJECT_ID.svc.id.goog

GKE_WORKLOAD_POOL=${GCP_BILLING_PROJECT}.svc.id.goog

# Enable Workload Identity on existing cluster.

gcloud container clusters update ${GKE_CLUSTER} --zone=${GCP_RESOURCE_ZONE} \
  --workload-pool=${GKE_WORKLOAD_POOL}

# Enable Workload Identity on desired node pools.

# Modify an existing node pool to enable GKE_METADATA. This update succeeds only if Workload Identity is enabled on the cluster. It immediately enables Workload Identity for workloads deployed to the node pool. This change will prevent workloads from using the Compute Engine service account and must be carefully rolled out.

# $ gcloud iam service-accounts list
# DISPLAY NAME                            EMAIL                                               DISABLED
# Compute Engine default service account  xxxxxxxxxxxx-compute@developer.gserviceaccount.com  False

gcloud container node-pools list --cluster ${GKE_CLUSTER} --zone=${GCP_RESOURCE_ZONE}

CLUSTER_NODEPOOL_NAME=default-pool

gcloud container node-pools update ${CLUSTER_NODEPOOL_NAME} \
  --cluster=${GKE_CLUSTER} --zone=${GCP_RESOURCE_ZONE} \
  --workload-metadata=GKE_METADATA

# Create Kubernetes service account for cluster applications.

K8S_SERVICE_ACCOUNT_NAME=jupyterhub1-users
kubectl create serviceaccount --namespace ${K8S_NAMESPACE} ${K8S_SERVICE_ACCOUNT_NAME}

# Create a (global) Google service account for users of this JupyterHub instance.

gcloud iam service-accounts create ${K8S_SERVICE_ACCOUNT_NAME} # Use Kubernetes service account name from above. This ensures we know what the global SA is about.

# Allow the Kubernetes service account to impersonate the Google service account.

IAM_SERVICE_ACCOUNT=${K8S_SERVICE_ACCOUNT_NAME}@${GCP_BILLING_PROJECT}.iam.gserviceaccount.com

gcloud iam service-accounts add-iam-policy-binding \
  --member "serviceAccount:${GKE_WORKLOAD_POOL}[${K8S_NAMESPACE}/${K8S_SERVICE_ACCOUNT_NAME}]" \
  --role roles/iam.workloadIdentityUser \
  ${IAM_SERVICE_ACCOUNT}

# Note, if the above IAM binding does not exist, the Pod will not be able to use the above Google service account.
# Now, annotate the Kubernetes cluster.

kubectl annotate serviceaccount \
  --namespace ${K8S_NAMESPACE} \
  ${K8S_SERVICE_ACCOUNT_NAME} \
  iam.gke.io/gcp-service-account=${IAM_SERVICE_ACCOUNT}

# Give the workload identity service account object storage read-access.
# Note, this command failed and this was set up via the Google web console.

#gsutil iam ch ${IAM_SERVICE_ACCOUNT}:legacyObjectReader gs://${GCP_BUCKET_NAME}
#CommandException: Incorrect public member type for binding ${IAM_SERVICE_ACCOUNT}:legacyObjectReader

