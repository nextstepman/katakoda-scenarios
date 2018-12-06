First step - install Kubernetes

## First setup kubernetes on the master node

`kubeadm init --pod-network-cidr=10.244.0.0/16`{{execute}}

This will take some time. This will output something like this 



```
...

Your Kubernetes master has initialized successfully!

...

You can now join any number of machines by running the following on each node
as root:

  kubeadm join 172.17.0.16:6443 --token r930zf.w4esesenl99em6bw --discovery-token-ca-cert-hash sha256:62c3dd1266e46a3bd3b6d10a0a327e16494c7db8e04bf8a7d6321ad3d50a12fe
kubeadm join 172.17.0.45:6443 --token ylq5y1.d2c70q3vnlhlc49l --discovery-token-ca-cert-hash sha256:ee81b6a09e53983bb62d3d1acefec501d8c24659cd278e1b1af35379474c9a37
```

Execute this command to check your cluster:

`kubectl get nodes`{{execute}}

It should show something like this:

```
master $ kubectl get nodes
NAME      STATUS     ROLES     AGE       VERSION
master    NotReady   master    6m        v1.11.3
```

Now we have just a single cluster node. 

## Join the first node

`kubectl delete node node01 --ignore-not-found=true && ssh node01 kubeadm reset --force && ssh node01 $(kubeadm token create --print-join-command)`{{execute}}`

What this long script does is:

1. remove the node from the cluster if it was already there
2. reset the node to empty state if something was already there
3. make the node join initialize and join the cluster

Answer yes if you get a message like this:
```
The authenticity of host 'node01 (172.17.0.31)' can't be established.
ECDSA key fingerprint is SHA256:QcAm6fpeYSCdk+ZK+J4tq1sLG/4P07eaLfe9H9jtTAo.
Are you sure you want to continue connecting (yes/no)? yes
```

If all goes well, above command should output something like this:

```
...
This node has joined the cluster:
* Certificate signing request was sent to master and a response
  was received.
* The Kubelet was informed of the new secure connection details.

Run 'kubectl get nodes' on the master to see this node join the cluster.
```

## Check that the node is there

Execute this command to setup your kubectl environment

`export KUBECONFIG=/etc/kubernetes/admin.conf`{{execute}}

Next check that the node joined the cluster

`kubectl get nodes`{{execute}}

This still show "NotReady", but this is fine

## Setup the flannel network

Execute the following command to setup the flannel network. This is required as above init does not yet setup an overlay network required
to have a fully functional kubernetes cluster.

`kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/bc79dd1505b0c8681ece4de4c0d86c5cd2643275/Documentation/kube-flannel.yml`{{execute}}

Now again check the status of the nodes

`kubectl get nodes`{{execute}}

This should progress to Ready

Make sure that above command outputs something like this, otherwise the Continue button won't let you

```
```








