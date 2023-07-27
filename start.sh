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