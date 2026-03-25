# Comandos Kubernetes - Laboratorio

```powershell
# 1. Iniciar Minikube
minikube start

# 2. Ver el nodo
kubectl get nodes

# 3. Crear pod con aplicación de nginx
kubectl run web-nginx --image=nginx

# 4. Ver el pod
kubectl get pods

# 5. Crear deployment
kubectl create deployment web-deployment --image=nginx

# 6. Ver deployment
kubectl get deployments

# 7. Escalar a 3 réplicas
kubectl scale deployment web-deployment --replicas=3

# 8. Ver pods escalados
kubectl get pods

# 9. Exponer el servicio
kubectl expose deployment web-deployment --type=NodePort --port=80

# 10. Ver services
kubectl get services

# 11. Ver todo
kubectl get all

# 12. Abrir la app en el navegador (dejar corriendo en una terminal)
kubectl port-forward service/web-deployment 8080:80
```


---

# Limpiar todo (para volver a probar desde cero)

```powershell
# Eliminar el service
kubectl delete service web-deployment

# Eliminar el deployment
kubectl delete deployment web-deployment

# Eliminar el pod 
kubectl delete pod web-nginx

# Verificar que no queda nada
kubectl get all

# Opcional: detener Minikube
minikube stop

# Opcional: eliminar el clúster completamente
minikube delete
```

