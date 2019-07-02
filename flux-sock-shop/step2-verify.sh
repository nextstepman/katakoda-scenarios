#!/bin/bash

export KUBECONFIG=/etc/kubernetes/admin.conf

kubectl get pods -n istio-system | grep ContainerCreating
if [ $? -eq 0 ]
then
  echo "istio is not Ready yet"
  exit 1
fi

kubectl get pods -n istio-system | grep Running
if [ $? -ne 0 ]
then
  echo "istio is not Ready yet"
  exit 1
fi

echo done
exit 0
