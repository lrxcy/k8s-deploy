#!/bin/bash

set -e

# Reset firstly if ran kubeadm init before
kubeadm reset -f

# kubeadm init with calico network
CONTROL_PLANE_ENDPOINT="$1"
# IMAGE_REPOSITORY=registry.cn-shenzhen.aliyuncs.com/cookcodeblog
IMAGE_REPOSITORY=k8s.gcr.io

# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#initializing-your-control-plane-node
# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#considerations-about-apiserver-advertise-address-and-controlplaneendpoint

kubeadm init \
  --kubernetes-version=v1.19.3 \
  --control-plane-endpoint=${CONTROL_PLANE_ENDPOINT} \
  --pod-network-cidr=10.20.0.0/16 \
  --image-repository=${IMAGE_REPOSITORY} \
  --upload-certs


# Make kubectl works
./enable_kubectl_master.sh


# Get cluster information
kubectl cluster-info
