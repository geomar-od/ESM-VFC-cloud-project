
GKE_CLUSTER=jupyterhub-cluster-1
NAMESPACE=jupyterhub-k8s-1

kubectl get nodes --namespace ${NAMESPACE}

gcloud container clusters \
  resize ${GKE_CLUSTER} \
  --zone europe-west3-b \
  --num-nodes=1

kubectl get nodes --namespace ${NAMESPACE}

kubectl get pods --namespace ${NAMESPACE}

# NAME                              READY   STATUS    RESTARTS   AGE
# continuous-image-puller-4rhmj     1/1     Running   0          24m
# hub-7c8597577c-vq9jv              1/1     Running   0          27m
# proxy-77579d8ff-wc76j             1/1     Running   0          27m
# user-scheduler-664fddc558-dkj6n   1/1     Running   0          27m
# user-scheduler-664fddc558-fx26k   1/1     Running   0          27m
