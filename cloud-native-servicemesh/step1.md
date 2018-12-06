First step - install Kubernetes

## Task

First setup kubernetes on the master node

`kubeadm init --pod-network-cidr=10.244.0.0/1`{{execute}}

Setup your kubectl to connect to kubernetes

`export KUBECONFIG=/etc/kubernetes/admin.conf` {{execute}}

Wait until the cluster is up

`kubectl get cs` {{execute}}

