Forth step - Setup sock shop to run with istio

## Delete the sock shop application again

Execute this command

`kubectl delete -f manifests`{{execute}}

## Enable auto injection in istio for the default namespace

Execute this command

`kubectl label namespace default istio-injection=enabled --overwrite`{{execute}}

## Reinstall the sock shop

Execute this command

`kubectl create -f manifests`{{execute}}

Now the sock shop should be installed, but with istio sidecars in it. 
You can verify by having a look at the pods. Each should have two containers


`kubectl get pods`{{execute}}

This should look something like this:

```
master $ kubectl get pods
NAME                            READY     STATUS    RESTARTS   AGE
catalogue-75fdd68798-kqwzb      2/2       Running   0          1m
catalogue-db-7d56b449cf-whlqn   2/2       Running   0          1m
front-end-5d7c476645-ctvph      2/2       Running   0          1m
```

Important is to have the `2/2` which shows that there are 2 containers in each pod.

## Open the jaeger console

First create a service with type node port, so we can access the jaeger console

`kubectl expose deployment istio-tracing -n istio-system --port 16686 --type NodePort --name jaeger`{{execute}}

Get the node port:

`kubectl get service -n istio-system jaeger`{{execute}}

It should output something like this
```
master $ kubectl get service -n istio-system jaeger
NAME      TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)           AGE
jaeger    NodePort   10.110.174.9   <none>        16686:31299/TCP   9s
```

Copy the port behind the colon, which is 31299 in above example. 
Click on the "+" next to terminal and open that port on Host "Host 1". You should get the Jaeger console
