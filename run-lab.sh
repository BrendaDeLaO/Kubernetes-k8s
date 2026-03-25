#!/usr/bin/env bash
# ============================================================
# Laboratorio: Despliegue de Nginx en Kubernetes con Minikube
# ============================================================
set -e

echo ""
echo "========================================"
echo " PASO 1: Iniciar Minikube"
echo "========================================"
minikube start
echo ""
echo "--- kubectl get nodes ---"
kubectl get nodes

echo ""
echo "========================================"
echo " PASO 2: Construir imagen dentro de Minikube"
echo "========================================"
# Apunta el daemon de Docker al de Minikube para que la imagen quede disponible en el clúster
eval $(minikube docker-env)
docker build -t lab-nginx:latest ./app
echo "Imagen lab-nginx:latest construida."

echo ""
echo "========================================"
echo " PASO 3: Crear Pod individual (web-nginx)"
echo "========================================"
# Si ya existe lo eliminamos para evitar error
kubectl delete pod web-nginx --ignore-not-found
kubectl run web-nginx --image=lab-nginx:latest --image-pull-policy=Never
echo "Esperando que el pod esté listo..."
kubectl wait --for=condition=Ready pod/web-nginx --timeout=60s
echo ""
echo "--- kubectl get pods ---"
kubectl get pods

echo ""
echo "========================================"
echo " PASO 4: Crear Deployment"
echo "========================================"
kubectl delete deployment web-deployment --ignore-not-found
kubectl apply -f k8s/deployment.yaml
echo "Esperando rollout del deployment..."
kubectl rollout status deployment/web-deployment
echo ""
echo "--- kubectl get deployments ---"
kubectl get deployments

echo ""
echo "========================================"
echo " PASO 5: Escalar a 3 réplicas"
echo "========================================"
kubectl scale deployment web-deployment --replicas=3
kubectl rollout status deployment/web-deployment
echo ""
echo "--- kubectl get pods ---"
kubectl get pods

echo ""
echo "========================================"
echo " PASO 6: Exponer con Service NodePort"
echo "========================================"
kubectl apply -f k8s/service.yaml
echo ""
echo "--- kubectl get services ---"
kubectl get services

echo ""
echo "========================================"
echo " PASO 7: Ver todos los recursos"
echo "========================================"
kubectl get all

echo ""
echo "========================================"
echo " PASO 8: Abrir aplicación en el navegador"
echo "========================================"
minikube service web-deployment
