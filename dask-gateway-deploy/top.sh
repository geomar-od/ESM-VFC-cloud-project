
echo ''; kubectl top pod --all-namespaces
echo ''; kubectl top node

# https://stackoverflow.com/a/48983984

echo ''; kubectl get pod --all-namespaces \
  -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName

#
# Debugging
# https://kubernetes.io/docs/tasks/debug-application-cluster/_print/
# kubectl describe pod dask-worker-.... --namespace ${K8S_NAMESPACE}
#
