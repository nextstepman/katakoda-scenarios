#!/bin/bash

export KUBECONFIG=/etc/kubernetes/admin.conf

kubectl get pods -n default -l name=flux | grep Running
if [ $? -eq 0 ]
then
  echo "flux is not Runnig yet"
  exit 1
fi


echo done
exit 0
