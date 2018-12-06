Second step - setup istio. This requires that your kubernetes cluster is already up and running, which you did in Step 1.

## Download the latest ISTIO release

Run the following command to download istio

`curl -L https://git.io/getLatestIstio | sh -`{{execute}}

This will download the latest version of ISTIO and unpack it

## Install istio in your cluster

First add istio to your path

`export PATH="$PATH:$(echo /root/istio-*/bin)"`{{execute}}

Change to the istio folder

`cd istio-*`{{execute}}

Add the istio custom ressource definition files

`kubectl apply -f install/kubernetes/helm/istio/templates/crds.yaml`{{execute}}

And deploy istio to your cluster

`kubectl apply -f install/kubernetes/istio-demo-auth.yaml`{{execute}}

## Verify istio installation

Execute the following command to check if the istio pods got started

`kubectl get pods --namespace istio-system`{{execute}}

All pods should be either in status Running or Completed



