
GKE_CLUSTER=jupyterhub-cluster-1
NAMESPACE=jupyterhub-k8s-1

# Note, bringing down the JupyterHub Kubernetes cluster gracefully (w/o producing any costs!) is a bit more complex than scaling compute instances down like this here!
# At the moment, there are, e.g., still "Network Node Balancing: Forwarding Rule" plus, e.g., the persistent user storage, as well as the JupyterHub database PVC storage charges accumulating.

# Manually drain JupyterHub nodes.

kubectl get nodes --namespace ${NAMESPACE}

# https://github.com/jupyterhub/zero-to-jupyterhub-k8s/issues/1934
# https://kubesphere.io/docs/cluster-administration/shut-down-and-restart-cluster-gracefully/

kubectl get nodes -o name --namespace ${NAMESPACE} | xargs -I {} kubectl drain {} --ignore-daemonsets --disable-eviction --delete-emptydir-data --force

# Manually delete remaining pods.

# https://stackoverflow.com/questions/46838221/how-to-stop-a-kubernetes-cluster

kubectl get pods --namespace ${NAMESPACE}

kubectl delete pods --all --namespace ${NAMESPACE}

kubectl get pods --namespace ${NAMESPACE}

# NAME                              READY   STATUS    RESTARTS   AGE
# continuous-image-puller-bn879     1/1     Running   0          18s
# hub-7c8597577c-vn76h              0/1     Pending   0          18s
# proxy-77579d8ff-m6xs2             0/1     Pending   0          18s
# user-scheduler-664fddc558-74ptz   0/1     Pending   0          18s
# user-scheduler-664fddc558-pbsnh   0/1     Pending   0          18s

# Finally, resize the default JupyterHub node pool to zero.

# https://cloud.google.com/kubernetes-engine/docs/how-to/managing-clusters#resizing_clusters
# https://cloud.google.com/kubernetes-engine/docs/how-to/resizing-a-cluster

gcloud container clusters \
  resize ${GKE_CLUSTER} \
  --zone europe-west3-b \
  --num-nodes=0

kubectl get pods --namespace ${NAMESPACE}

# NAME                              READY   STATUS    RESTARTS   AGE
# hub-7c8597577c-vq9jv              0/1     Pending   0          11s
# proxy-77579d8ff-wc76j             0/1     Pending   0          11s
# user-scheduler-664fddc558-dkj6n   0/1     Pending   0          11s
# user-scheduler-664fddc558-fx26k   0/1     Pending   0          11s
