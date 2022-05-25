#!/usr/bin/env bash

# follow some bash script best practices - https://kvz.io/bash-best-practices.html
set -o errexit
set -o pipefail
set -o nounset

echo "Creating Resource Group api-platform..."
az group create --name api-platform --location "UK South"
echo "Creating AKS Cluster"
az deployment group create --name PlatformDeployment --resource-group api-platform --template-file template/template.json --parameters template/parameters.json

echo "Configuring kube context..."
az aks get-credentials --resource-group api-platform --name platform-internal --overwrite-existing

echo "Configuring Attendees Service"
kubectl create -f k8s/attendees-deployment.yaml
kubectl create -f k8s/attendees-service.yaml
echo "Configuring Gateway"
kubectl create -f k8s/gateway-deployment.yaml
echo "Exposing LoadBalancer for Gateway"
kubectl create -f k8s/gateway-service.yaml