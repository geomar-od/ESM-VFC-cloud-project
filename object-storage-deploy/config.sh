
source secrets.sh

GCP_BILLING_PROJECT=${GCP_BILLING_PROJECT}

# Note, compute engine zones are not bucket locations!
# https://cloud.google.com/storage/docs/locations

GCP_BUCKET_LOCATION=${GCP_BUCKET_LOCATION}

# Note, you must choose your own, globally-unique, bucket name.
# Do not include sensitive information, since the bucket namespace is global and publicly visible.
# https://cloud.google.com/storage/docs/quickstart-gsutil#create

GCP_BUCKET_NAME=${GCP_BUCKET_NAME}

# Note, this needs to be in a GCP workload identity compatible pattern.
# https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity

GCP_BUCKET_IAM_SERVICE_ACCOUNT_NAME_PREFIX=${GCP_BUCKET_IAM_SERVICE_ACCOUNT_NAME_PREFIX}
GCP_BUCKET_IAM_SERVICE_ACCOUNT_NAME=${GCP_BUCKET_IAM_SERVICE_ACCOUNT_NAME_PREFIX}@${GCP_BILLING_PROJECT}.iam.gserviceaccount.com
