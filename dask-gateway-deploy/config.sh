
source secrets.sh

# Specify GCP-related things.

GCP_BILLING_PROJECT=${GCP_BILLING_PROJECT}
GCP_RESOURCE_ZONE=${GCP_RESOURCE_ZONE}

# Dask gateway default node pool.

GKE_CLUSTER_NAME=dask-gateway-1

# Kubernetes namespace.

K8S_NAMESPACE=dask-gateway-1

# Helm release options.

HELM_RELEASE_NAME=dask-gateway-1
HELM_CHART_VERSION=0.9.0

# Access permission options.
# These should be arrays?

IAM_SERVICE_ACCOUNT_NAME_PREFIX=${IAM_SERVICE_ACCOUNT_NAME_PREFIX}
IAM_SERVICE_ACCOUNT_NAME=${IAM_SERVICE_ACCOUNT_NAME_PREFIX}@${GCP_BILLING_PROJECT}.iam.gserviceaccount.com

# Deploy Gateway in JupyterHub namespace.

GKE_CLUSTER_NAME=jupyterhub-cluster-1
K8S_NAMESPACE=jupyterhub-k8s-1
