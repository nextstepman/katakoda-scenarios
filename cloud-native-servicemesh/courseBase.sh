#!/bin/sh

# setup known hosts
ssh -oStrictHostKeyChecking=no node01 id

# prepull images to have a quick startup
kubeadm config images pull
