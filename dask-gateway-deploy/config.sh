
source secrets.sh

# Specify GCP-related things.

GCP_BILLING_PROJECT=${GCP_BILLING_PROJECT}
GCP_RESOURCE_ZONE=${GCP_RESOURCE_ZONE}

# Dask gateway default node pool.

GKE_CLUSTER_NAME=daskgateway2

# Kubernetes namespace.

K8S_NAMESPACE=daskgateway2

# Helm release options.

HELM_RELEASE_NAME=daskgateway2
HELM_CHART_VERSION=0.9.0

# Access permission options.

IAM_SERVICE_ACCOUNT_PREFIX=daskgateway2

IAM_SERVICE_ACCOUNT_SUFFIX=${GCP_BILLING_PROJECT}.iam.gserviceaccount.com # Don't change.
IAM_SERVICE_ACCOUNT_NAME=${IAM_SERVICE_ACCOUNT_PREFIX}@${IAM_SERVICE_ACCOUNT_SUFFIX} # Don't change.
GKE_WORKLOAD_POOL=${GCP_BILLING_PROJECT}.svc.id.goog # Don't change.

# Deploy Gateway alongside JupyterHub.
# If you’re not deploying Dask-Gateway in the same cluster and namespace as JupyterHub, you will need to specify JupyterHub’s API url.
# If JupyterHub and Dask-Gateway are on the same cluster and namespace you can omit this configuration key, and the address will be inferred automatically.
# https://gateway.dask.org/install-kube.html#authenticating-with-jupyterhub
# This is convenient, therefore specify the JupyterHub's Kubernetes namespace.

GKE_CLUSTER_NAME=jupyterhub2
K8S_NAMESPACE=jupyterhub2

# For simplicity, we'll also rely on JupyterHub's service account for non-public storage authorization here.

IAM_SERVICE_ACCOUNT_PREFIX=jupyterhub2
IAM_SERVICE_ACCOUNT_SUFFIX=${GCP_BILLING_PROJECT}.iam.gserviceaccount.com # Don't change.
IAM_SERVICE_ACCOUNT_NAME=${IAM_SERVICE_ACCOUNT_PREFIX}@${IAM_SERVICE_ACCOUNT_SUFFIX} # Don't change.
GKE_WORKLOAD_POOL=${GCP_BILLING_PROJECT}.svc.id.goog # Don't change.
