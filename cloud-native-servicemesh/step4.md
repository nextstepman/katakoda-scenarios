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
catalogue-db-7d56b449cf-whlqn   1/1       Running   0          1m
front-end-5d7c476645-ctvph      2/2       Running   0          1m
```

Important is to have the `2/2` which shows that there are 2 containers in each pod.

## Open the jaeger console

Expose the jaeger console on a port

`kubectl port-forward -n istio-system $(kubectl get pod -n istio-system -l app=jaeger -ojsonpath='{.items[0].metadata.name}') 16686:16686 &> /dev/null &`{{execute}}

And run socat to make that accessible from the outside

`socat TCP-LISTEN:16687,fork TCP:127.0.0.1:16686 &> /dev/null &`{{execute}}

Open this link to access Jaeger ihe browser

https://[[HOST_SUBDOMAIN]]-16687-[[KATACODA_HOST]].environments.katacoda.com/

For now you won't see much there, we need to create some traffic

## Open a console to the sock shop

Expose the web front end on a port

`kubectl port-forward $(kubectl get pod -l app=front-end -ojsonpath='{.items[0].metadata.name}') 8079:8079 &> /dev/null &`{{execute}}

And run socat to make that accessible from the outside
 
`socat TCP-LISTEN:18079,fork TCP:127.0.0.1:8079 &> /dev/null &`{{execute}}

Open this link to access the browser

https://[[HOST_SUBDOMAIN]]-18079-[[KATACODA_HOST]].environments.katacoda.com/

Now access the catalog some time to create some traffic.
Go back to the jaeger console and select "front-end" in the drop down box. Reload if it is not there yet. Next click *Find Traces*. 
Now you should see some.

## Clean up and kill the port forwarding processes again

Above snippet created background jobs in the shell. 
Run this command to stop them again. 

`kill $(jobs -p)`{{execute}}

After that, the web pages cannot be accessed
