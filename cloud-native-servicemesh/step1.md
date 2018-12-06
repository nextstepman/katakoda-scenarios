First step - install Kubernetes

## First setup kubernetes on the master node

`kubeadm init --pod-network-cidr=10.244.0.0/16`{{execute}}

This will output something like this 

```
kubeadm join 172.17.0.45:6443 --token ylq5y1.d2c70q3vnlhlc49l --discovery-token-ca-cert-hash sha256:ee81b6a09e53983bb62d3d1acefec501d8c24659cd278e1b1af35379474c9a37
```

## Join the first node

Login to the node

`ssh node01`{{execute}}

## Join the node to the cluster

First reset the node, in case some config is there

`kubeadm reset`{{execute}}

Next join the node to the cluster by copy the outputted kubeadm join command - the real one, not the one shown as example.

Next exit the node

`exit`{{execute}}

Now your shell should be back on the master node.

## Setup your kubectl to connect to kubernetes

`export KUBECONFIG=/etc/kubernetes/admin.conf`{{execute}}

Check that the node joined the cluster

`kubectl get nodes`{{execute}}

This still show "NotReady", but this is fine

## Setup the flannel network

`kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/bc79dd1505b0c8681ece4de4c0d86c5cd2643275/Documentation/kube-flannel.yml`{{execute}}

Now again check the status of the nodes

`kubectl get nodes`{{execute}}

This should progress to Ready








