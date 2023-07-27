# Installation

Activer kubernetes sur docker desktop

Puis activer ingress-nginx pour les redirection avec ingress

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.41.2/deploy/static/provider/cloud/deploy.yaml
```

# Lancer & supprmer rapidement

```bash
./start.sh # pour lancer
./stop # pour supprimer
```

# Créer l’infrastructure (explication)

## Ingress

L’ingress permet de créer notre nom d’hôte et d’y lier nos services en fonction de leur chemin (path). 

Ne pas oublier le **ingressClassName : nginx** sur **windows**

```yaml
# kubernetes/ingress.yml
apiVersion: networking.k8s.io/v1
kind: Ingress

metadata:
  name: tp3-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /$1

spec:
  ingressClassName: nginx
  rules:
  - host: tp3.test
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: tp3-web1
            port:
              number: 80
      - path: /prof2math
        pathType: Prefix
        backend:
          service:
            name: tp3-web2
            port:
              number: 80
```

## Services

On viens créer ici un de nos deux services (ici avec tp3-web1) de type NodePort (redirection) sur le port 80 (http). Il herite de notre deployment tp3-web1

```yaml
# kubernetes/service_web1.yml
apiVersion: v1
kind: Service

metadata:
  name: tp3-web1
  labels:
    app: tp3-web1

spec:
  type: NodePort
  ports:
  - port: 80
    targetPort: 80
    protocol: TCP
    name: http
  selector:
    app: tp3-web1
```

## Deployments

On viens créer ici nos deployment qui seront nos containers et qui hérite de notre images tp3-web1 dans notre cas.

On n’oubliera pas l’**imagePullPolicy : Never** pour que l’image arrive à se lancer avec le service.

```yaml
# deployement_web1.yml
apiVersion: apps/v1
kind: Deployment

metadata:
  name: tp3-web1
  labels:
    app: tp3-web1

spec:
  selector:
    matchLabels:
      app: tp3-web1
  template:
    metadata:
      labels:
        app: tp3-web1
    spec:
      containers:
      - name: tp3-web1
        image: tp3-web1
        imagePullPolicy: Never
        ports:
        - containerPort: 80
```

# Lancer

On commence par build nos images docker (tp3-web1 et tp3-web2).

Puis on lance nos deployments, nos services, notre ingress.

Et on fini par montrer l’état de nos pods, ingress et services, 

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

## Stopper / suppression

On supprime ici nos ingress, services et deployments

```bash
# delete ingress, pods, services, deployments using kubectl
kubectl delete -f kubernetes/ingress.yml

kubectl delete -f kubernetes/service_web1.yml
kubectl delete -f kubernetes/service_web2.yml

kubectl delete -f kubernetes/deployment_web1.yml
kubectl delete -f kubernetes/deployment_web2.yml
```