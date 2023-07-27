# delete ingress, pods, services, deployments using kubectl
kubectl delete -f kubernetes/ingress.yml

# kubectl delete -f kubernetes/pod_web1.yml
# kubectl delete -f kubernetes/pod_web2.yml

kubectl delete -f kubernetes/service_web1.yml
kubectl delete -f kubernetes/service_web2.yml

kubectl delete -f kubernetes/deployment_web1.yml
kubectl delete -f kubernetes/deployment_web2.yml