#!/bin/bash
sed "s/KEYCLOAK_HOST/keycloak.$(minikube ip).nip.io/" ingress-template.yaml > 06_ingress.yaml
kubectl apply -f 01_namespace.yaml -f 02_secrets.yaml -f 03_storage.yaml -f 04_postgres.yaml -f 05_keycloak.yaml -f 06_ingress.yaml
