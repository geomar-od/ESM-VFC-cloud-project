
source gcp-config.sh
source gcp-bucket-config.sh

# The -c and -l options specify the storage class and location, respectively,
# for the bucket. Once a bucket is created in a given location and with a
# given storage class, it cannot be moved to a different location, and the
# storage class cannot be changed. Instead, you would need to create a new
# bucket and move the data over and then delete the original bucket.

# https://cloud.google.com/storage/docs/quickstart-gsutil#create
# https://cloud.google.com/storage/docs/storage-classes

gsutil mb \
  -p ${GCP_BILLING_PROJECT} \
  -l ${GCP_BUCKET_LOCATION} \
  -c standard \
  gs://${GCP_BUCKET_NAME}/

# https://cloud.google.com/storage/docs/gsutil/commands/pap
# gsutil pap set enforced gs://<bucket_name>...

# https://cloud.google.com/storage/docs/gsutil/commands/bucketpolicyonly

gsutil bucketpolicyonly get gs://${GCP_BUCKET_NAME}
gsutil bucketpolicyonly set on gs://${GCP_BUCKET_NAME}
gsutil bucketpolicyonly get gs://${GCP_BUCKET_NAME}

# https://cloud.google.com/storage/docs/access-control/using-iam-permissions
# https://cloud.google.com/storage/docs/access-control/iam-roles

# WIP
# https://cloud.google.com/storage/docs/access-control/making-data-public
# Note, roles/storage.objectViewer includes permission to list the objects in the bucket. If you don't want to grant listing publicly, use roles/storage.legacyObjectReader.
# Thinking about the least-privilege principle, that's what is chosen for now.

gsutil iam get gs://${GCP_BUCKET_NAME}
gsutil iam ch allUsers:legacyObjectReader gs://${GCP_BUCKET_NAME}
gsutil iam get gs://${GCP_BUCKET_NAME}

