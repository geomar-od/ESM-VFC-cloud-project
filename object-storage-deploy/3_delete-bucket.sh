
source config.sh

# Delete bucket.

# Warning: The gsutil rm command also deletes all objects stored within the bucket. These objects cannot be recovered. If you want to avoid accidentally deleting objects, use the gsutil rb command, which only deletes a bucket if the bucket is empty.
# Note: If you have to delete a large number of objects in your buckets, avoid using gsutil, as the operation takes a long time to complete. Instead, use the Cloud Console or Object Lifecycle Management. For more information, see Deleting data best practices.
# https://cloud.google.com/storage/docs/deleting-buckets

gsutil rb gs://${GCP_BUCKET_NAME}
