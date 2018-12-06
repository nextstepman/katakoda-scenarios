Third step - setup the sock shop application and deploy it.

## Install the sock shop application

Deploy the files from the manifest folder. This will setup the sock shop application.
See https://github.com/microservices-demo for more info about that application

Execute this command to deploy it:


`kubectl create -f manifests`{{execute}}

Next wait until the sock shop is deployed. Execute this command to check its status

`kubectl get pods`{{execute}}

It should show all pods as running.

## Open the sock shop

Find the port the sock shops frontend is exposed

`kubectl get service front-end`{{execute}}

This will display something like this:
```
master $ kubectl get service front-end
NAME        TYPE       CLUSTER-IP    EXTERNAL-IP   PORT(S)          AGE
front-end   NodePort   10.96.71.84   <none>        8079:30922/TCP   8m
```

Find the port the service is exposed at. In above example this is 30922

## Open a web browser in katacoda to that port

Expose the web front end on a port

`kubectl port-forward $(kubectl get pod -l app=front-end -ojsonpath='{.items[0].metadata.name}') 8079:8079 &`{{execute}}

 And run socat to make that accessible from the outside
 
`socat TCP-LISTEN:18079,fork TCP:127.0.0.1:8079 &`{{execute}}

Open this link:

https://[[HOST_SUBDOMAIN]]-18079-[[KATACODA_HOST]].environments.katacoda.com/






