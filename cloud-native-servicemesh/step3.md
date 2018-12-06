First step - install Kubernetes

## Task

First setup kubernetes on the master node

`kubeadm init --pod-network-cidr=10.244.0.0/16`{{execute}}

Setup your kubectl to connect to kubernetes

`export KUBECONFIG=/etc/kubernetes/admin.conf`{{execute}}

Wait until the cluster is up

`kubectl get cs`{{execute}}

This will output something like this:

```
kubeadm join 172.17.0.45:6443 --token 95dvw1.w1uinl5y6o2rhxdg --discovery-token-ca-cert-hash sha256:25f43a069a0cdb8d894d5bdd9a86fba7f394f2aeec797bfa26cd004818abbdb3
```

Copy the output (not the above example) and execute it on the second kubernetes node by ssh'ing into that node like this:

`ssh node01`{{execute}}



