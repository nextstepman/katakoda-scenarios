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

Expose the jaeger console on a port

`kubectl port-forward -n istio-system $(kubectl get pod -n istio-system -l app=jaeger -ojsonpath='{.items[0].metadata.name}') 16686:16686 &`{{execute}}

And run socat to make that accessible from the outside

`socat TCP-LISTEN:16687,fork TCP:127.0.0.1:16686 &`{{execute}}

## Open a console to the sock shop

Expose the web front end on a port

`kubectl port-forward $(kubectl get pod -l app=front-end -ojsonpath='{.items[0].metadata.name}') 8079:8079 &`{{execute}}

 And run socat to make that accessible from the outside
 
`socat TCP-LISTEN:18079,fork TCP:127.0.0.1:8079 &`{{execute}}
