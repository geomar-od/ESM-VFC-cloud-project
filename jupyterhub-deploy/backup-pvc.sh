#!/bin/bash

source config.sh

PVCNAME=claim-user1

# https://stackoverflow.com/questions/50375826/kubernetes-how-to-download-a-persistentvolumes-content

cat << EOF | kubectl create --namespace ${K8S_NAMESPACE} -f -
apiVersion: v1
kind: Pod
metadata:
  name: pvc-mounter
spec:
  containers:
    - name: alpine
      image: alpine:latest
      command: ["sleep", "infinity"]
      volumeMounts:
        - name: ${PVCNAME}
          mountPath: /pvc
  volumes:
    - name: ${PVCNAME}
      persistentVolumeClaim:
        claimName: ${PVCNAME}
EOF

for attempt in {1..12}; do
 IS_POD_RUNNING=$(kubectl get pods --namespace ${K8S_NAMESPACE} | grep pvc-mounter | grep Running | wc -l)
 if [[ "$IS_POD_RUNNING" -eq 1 ]]; then
  break
 fi
 echo Waiting... 5 secs
 sleep 5
done

kubectl describe pods pvc-mounter --namespace ${K8S_NAMESPACE}

mkdir -p ./${PVCNAME}

kubectl cp pvc-mounter:/pvc ./${PVCNAME} --namespace ${K8S_NAMESPACE}

kubectl delete pod pvc-mounter --namespace ${K8S_NAMESPACE}

kubectl get pods --namespace ${K8S_NAMESPACE}

