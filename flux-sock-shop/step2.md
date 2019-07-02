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
To do so, create a fork of this one: https://github.com/nextstepman/test-flux-repo

## Update flux to use your repository

Edit file deploy/flux-deployment.yaml and add your git repository. Search for 
`--git-url` and replace the value with your cloned repository, e.g. `git@github.com:nextstepman/test-flux-repo.git`. You cannot use this one, as you need to have write access to that repository. 

`vi deploy/flux-deployment.yaml`{{execute}}

## Deploy flux

Execute this command to deploy flux:

`kubectl apply -f deploy`{{execute}}

## Grant flux access to your git repo

Execute this command to get the public key of your flux installation

`fluxctl identity`{{execute}}

Add that key to your git repo (in github, add a deploy key with write access)

## List workflows in flux

Now the sock-shop should be added as deployment.

`fluxctl list-workloads -n sock-shop`{{execute}}

It should show the sock-shop like this:

```
CONTROLLER                         CONTAINER     IMAGE                               RELEASE   POLICY
sock-shop:deployment/catalogue     catalogue     weaveworksdemos/catalogue:0.3.4     updating
sock-shop:deployment/catalogue-db  catalogue-db  weaveworksdemos/catalogue-db:0.3.0  ready
sock-shop:deployment/front-end     front-end     weaveworksdemos/front-end:0.3.12    ready
```