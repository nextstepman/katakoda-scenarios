First step - setup Kubernetes. Kubernetes is already installed, but we need to setup the master node and join a slave node.

## First setup kubernetes on the master node

`kubeadm init --pod-network-cidr=10.244.0.0/16`{{execute}}

This will take some time. This will output something like this 

```
...

Your Kubernetes master has initialized successfully!
...

```

If this does not work, you can reset the setting by executing `kubeadm reset` but be careful, this destroys the complete setup and
you will have to start from scratch.

Execute this command to setup your kubectl environment

`export KUBECONFIG=/etc/kubernetes/admin.conf`{{execute}}

Next execute this command to check your cluster:

`kubectl get nodes`{{execute}}

It should show something like this:

```
master $ kubectl get nodes
NAME      STATUS     ROLES     AGE       VERSION
master    NotReady   master    6m        v1.11.3
```

Now we have just a single cluster node. 

## Join the first node

Execute the following command to setup the kubernetes slave node and make it join the cluster.

`kubectl delete node node01 --ignore-not-found=true && ssh node01 kubeadm reset --force && ssh node01 $(kubeadm token create --print-join-command)`{{execute}}

What this long script does is:

1. remove the node from the cluster if it was already there
2. reset the node to empty state if something was already there
3. make the node join initialize and join the cluster

Answer yes if you get a message like this:
```
...
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

Execute this command to check that the node joined the cluster

`kubectl get nodes`{{execute}}

This still show "NotReady", but this is fine

## Setup the flannel network

Execute the following command to setup the flannel network. This is required as above init does not yet setup an overlay network required
to have a fully functional kubernetes cluster.

`kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/bc79dd1505b0c8681ece4de4c0d86c5cd2643275/Documentation/kube-flannel.yml`{{execute}}

Now again check the status of the nodes

`kubectl get nodes`{{execute}}

This should progress to Ready

Don't click Continue until status of all cluster nodes is Ready.