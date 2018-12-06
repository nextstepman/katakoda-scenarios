Third step - setup the sock shop application and deploy it.

## Install the sock shop application

Deploy the files from the manifest folder. This will setup the sock shop application.
See https://github.com/microservices-demo for more info about that application

Execute this command to deploy it:

`kubectl create -f manifests`{{execute}}

Next wait until the sock shop is deployed. Execute this command to check its status

`kubectl get pods`{{execute}}

It should show all pods as running.

## Expose the sock shop as port and connect via browser

Expose the web front end on a port

`kubectl port-forward $(kubectl get pod -l app=front-end -ojsonpath='{.items[0].metadata.name}') 8079:8079 &> /dev/null &`{{execute}}

And run socat to make that accessible from the outside
 
`socat TCP-LISTEN:18079,fork TCP:127.0.0.1:8079 &> /dev/null &`{{execute}}

Open this link to access the browser

https://[[HOST_SUBDOMAIN]]-18079-[[KATACODA_HOST]].environments.katacoda.com/

## kill the processes again

Above snippet created two background jobs in the shell. 
Run this command to stop them again. 

`kill $(jobs -p)`{{execute}}

After that, the web page cannot be accessed



