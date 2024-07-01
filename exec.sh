#!/bin/bash
sed "s/KEYCLOAK_HOST/keycloak.$(minikube ip).nip.io/" ingress-template.yml > 06_ingress.yml
kubectl apply -f 01_namespace.yml -f 02_secrets.yml -f 03_storage.yml -f 04_postgres.yml -f 05_keycloak.yml -f 06_ingress.yml
