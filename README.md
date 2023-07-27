# Installation

Activer kubernetes sur docker desktop

Puis activer ingress nginx pour les redirection avec ingress

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.41.2/deploy/static/provider/cloud/deploy.yaml
```

# Start

```bash
# prepare minikube environment
# minikube start --driver=docker

docker compose build

# start deployments
kubectl apply -f kubernetes/deployment_web1.yml
kubectl apply -f kubernetes/deployment_web2.yml

# start services
kubectl apply -f kubernetes/service_web1.yml
kubectl apply -f kubernetes/service_web2.yml

# # start pods
# kubectl apply -f kubernetes/pod_web1.yml
# kubectl apply -f kubernetes/pod_web2.yml

# start ingress
kubectl apply -f kubernetes/ingress.yml

# show pod & ingress & service using kubectl
echo "Pods:"
kubectl get pod

echo "Ingress:"
kubectl get ingress

echo "Services:"
kubectl get service
```

## Stop / delete

```bash
# delete ingress, pods, services, deployments using kubectl
kubectl delete -f kubernetes/ingress.yml

# kubectl delete -f kubernetes/pod_web1.yml
# kubectl delete -f kubernetes/pod_web2.yml

kubectl delete -f kubernetes/service_web1.yml
kubectl delete -f kubernetes/service_web2.yml

kubectl delete -f kubernetes/deployment_web1.yml
kubectl delete -f kubernetes/deployment_web2.yml
```