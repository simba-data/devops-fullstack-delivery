#!/bin/bash

echo "Démarrage du déploiement Kubernetes..."
kubectl apply -f ../k8s/ -n dev &>/dev/null || kubectl create namespace dev

echo "Configuration des secrets..."
kubectl apply -f ../k8s/secret.yaml -n dev &>/dev/null

echo "Lancement de Postgres..."
kubectl apply -f ../k8s/postgres.yaml -n dev &>/dev/null

echo "Attente du démarrage de Postgres..."
kubectl wait --for=condition=ready pod -l app=postgres -n dev --timeout=60s &>/dev/null

echo "Déploiement du Backend et du Frontend..."
kubectl apply -f ../k8s/backend.yaml -n dev &>/dev/null
kubectl apply -f ../k8s/frontend.yaml -n dev &>/dev/null

echo "Network Policies..."
kubectl apply -f ../k8s/network-policy.yaml -n dev &>/dev/null

echo "Déploiement terminé."
