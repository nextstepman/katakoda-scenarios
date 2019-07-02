#!/bin/bash

export KUBECONFIG=/etc/kubernetes/admin.conf

kubectl get node master | grep NotReady
if [ $? -eq 0 ]
then
  echo "The master node is not Ready yet"
  exit 1
fi

kubectl get node master | grep Ready
if [ $? -ne 0 ]
then
  echo "The master node is not Ready yet"
  exit 1
fi

kubectl get node node01 | grep NotReady
if [ $? -eq 0 ]
then
  echo "The node is not Ready yet"
  exit 1
fi

kubectl get node node01 | grep Ready
if [ $? -ne 0 ]
then
  echo "The node is not Ready yet"
  exit 1
fi

echo done
exit 0
