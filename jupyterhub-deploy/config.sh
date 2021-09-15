
source secrets.sh

# Specify GCP-related things.

GCP_BILLING_PROJECT=${GCP_BILLING_PROJECT}
GCP_RESOURCE_ZONE=${GCP_RESOURCE_ZONE}

# JupyterHub Kubernetes cluster name.

GKE_CLUSTER_NAME=jupyterhub2
GKE_CLUSTER_NAME=jupyterhub-cluster-1

# Kubernetes namespace.

K8S_NAMESPACE=jupyterhub2
K8S_NAMESPACE=jupyterhub-k8s-1

# Helm release options.

HELM_RELEASE_NAME=jupyterhub2
HELM_CHART_VERSION=1.1.2
HELM_RELEASE_NAME=jupyterhub-hr-1

# Specify Google workload identity stuff.
# Will be used to access non-public GCP object storage.

IAM_SERVICE_ACCOUNT_PREFIX=jupyterhub2

IAM_SERVICE_ACCOUNT_SUFFIX=${GCP_BILLING_PROJECT}.iam.gserviceaccount.com # Don't change.
IAM_SERVICE_ACCOUNT_NAME=${IAM_SERVICE_ACCOUNT_PREFIX}@${IAM_SERVICE_ACCOUNT_SUFFIX} # Don't change.
GKE_WORKLOAD_POOL=${GCP_BILLING_PROJECT}.svc.id.goog # Don't change.
