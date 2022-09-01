# go_todo_app_infra

Infrastructure of [go_todo_app](https://github.com/Rindrics/go_todo_app)

## Prerequisits

- [Docker](https://www.docker.com)
- [kind](https://kind.sigs.k8s.io)

## How to deploy

Deploy kubernetes cluster on local machine using kind:
```bash
$ make infra-apply
...
kind_cluster.new: Creating...
kind_cluster.new: Still creating... [10s elapsed]
kind_cluster.new: Still creating... [20s elapsed]
kind_cluster.new: Still creating... [30s elapsed]
kind_cluster.new: Still creating... [40s elapsed]
kind_cluster.new: Still creating... [50s elapsed]
kind_cluster.new: Still creating... [1m0s elapsed]
kind_cluster.new: Creation complete after 1m9s [id=docker/go-todo-infra]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
kubectl config set-context kind-go-todo-infra --namespace=gotodo-prd
Context "kind-go-todo-infra" modified.
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
namespace/ingress-nginx created
serviceaccount/ingress-nginx created
serviceaccount/ingress-nginx-admission created
role.rbac.authorization.k8s.io/ingress-nginx created
role.rbac.authorization.k8s.io/ingress-nginx-admission created
clusterrole.rbac.authorization.k8s.io/ingress-nginx created
clusterrole.rbac.authorization.k8s.io/ingress-nginx-admission created
rolebinding.rbac.authorization.k8s.io/ingress-nginx created
rolebinding.rbac.authorization.k8s.io/ingress-nginx-admission created
clusterrolebinding.rbac.authorization.k8s.io/ingress-nginx created
clusterrolebinding.rbac.authorization.k8s.io/ingress-nginx-admission created
configmap/ingress-nginx-controller created
service/ingress-nginx-controller created
service/ingress-nginx-controller-admission created
deployment.apps/ingress-nginx-controller created
job.batch/ingress-nginx-admission-create created
job.batch/ingress-nginx-admission-patch created
ingressclass.networking.k8s.io/nginx created
validatingwebhookconfiguration.admissionregistration.k8s.io/ingress-nginx-admission created
sleep 10
kubectl wait --namespace ingress-nginx \
	  --for=condition=ready pod \
	  --selector=app.kubernetes.io/component=controller \
	  --timeout=90s
pod/ingress-nginx-controller-9549c9fb9-zpgch condition met
```


```bash
$ make app-apply
...
kubectl apply -f manifest/namespace.yaml
namespace/gotodo-prd created
sleep 3
find manifest -type f | grep -v namespace | while read -r matched; do\
	  kubectl apply -f $matched;\
	done
deployment.apps/gotodo created
deployment.apps/gotodo-mysql created
ingress.networking.k8s.io/gotodo-ingress created
service/gotodo created
service/gotodo-mysql created
configmap/gotodo-mysql created
```

