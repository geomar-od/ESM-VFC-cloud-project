
source secrets.sh

# Specify GCP-related things.

GCP_BILLING_PROJECT=${GCP_BILLING_PROJECT}
GCP_RESOURCE_ZONE=${GCP_RESOURCE_ZONE}

# Dask gateway default node pool.

GKE_CLUSTER_NAME=dask-gateway-1
GKE_MACHINE_TYPE=e2-medium # Shared!

# Helm release options.

K8S_NAMESPACE=dask-gateway-1
HELM_RELEASE_NAME=dask-gateway-1
HELM_CHART_VERSION=0.9.0

# Access permission options.

IAM_SERVICE_ACCOUNT_NAME_PREFIX=${IAM_SERVICE_ACCOUNT_NAME_PREFIX}
IAM_SERVICE_ACCOUNT_NAME=${IAM_SERVICE_ACCOUNT_NAME_PREFIX}@${GCP_BILLING_PROJECT}.iam.gserviceaccount.com
