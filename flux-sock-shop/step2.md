Second step - setup flux. This requires that your kubernetes cluster is already up and running, which you did in Step 1.

## Download flux

Run the following command to download flux

`git clone https://github.com/weaveworks/flux && cd flux`{{execute}}

This will download the latest version of flux and change your working directory there

## Install fluxctl client

Execute this command to install the fluxctl client which you will need later

`sudo snap install fluxctl`{{execute}}

## Create a git repository for your deployment

Create your own git repository with deployments for flux.
To do so, create a fork of this one: https://github.com/nextstepman/test-flux-repo.
You cannot use it directly, as flux needs write access. Also we will use the git url and this one does not work
unless you add the flux public key which requires you to have write access on that repo.

## Update flux to use your repository

Edit file deploy/flux-deployment.yaml and add your git repository. Search for 
`--git-url`{{copy}} and replace the value with your cloned repository, e.g. `git@github.com:nextstepman/test-flux-repo.git`{{copy}}. You cannot use this one, as you need to have write access to that repository. 

The following step will open vi for that file.

`vi deploy/flux-deployment.yaml`{{execute}}

## Deploy flux

Execute this command to deploy flux:

`kubectl apply -f deploy`{{execute}}

## Grant flux access to your git repo

Execute this command to get the public key of your flux installation

`fluxctl identity`{{execute}}

This might fail at first, if flux is still deploying, so retry for some times. 
Add that key to your git repo (in github, add a deploy key with write access)

## List workflows in flux

Now the sock-shop should be added as deployment.

`fluxctl list-workloads -n sock-shop`{{execute}}

This might take some time after flux was started, as it requires flux to read the git repo first. 
You can trigger syncronization with this command:

`fluxctl sync`{{execute}}

It should show the sock-shop like this:

```
CONTROLLER                         CONTAINER     IMAGE                               RELEASE   POLICY
sock-shop:deployment/catalogue     catalogue     weaveworksdemos/catalogue:0.3.4     ready
sock-shop:deployment/catalogue-db  catalogue-db  weaveworksdemos/catalogue-db:0.3.0  ready
sock-shop:deployment/front-end     front-end     weaveworksdemos/front-end:0.3.12    ready
```

## List deployed application in kubernetes

Execute this command to see the deployed application:

`kubectl get pods -n sock-shop`{{execute}}

This should show that the sock shop was deployed.