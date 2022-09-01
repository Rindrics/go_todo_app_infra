CLUSTER=tffiles/cluster
TFCHDIR=terraform -chdir=
TFOPTS=-input=false -no-color
INIT=${TFCHDIR}${CLUSTER} init ${TFOPTS}

.PHONY: infra-plan
infra-plan:
	${INIT}
	${TFCHDIR}${CLUSTER} plan ${TFOPTS}

.PHONY: infra-apply
infra-apply:
	${INIT}
	${TFCHDIR}${CLUSTER} apply ${TFOPTS} -auto-approve
	kubectl config set-context kind-go-todo-infra --namespace=gotodo-prd
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
	sleep 10
	kubectl wait --namespace ingress-nginx \
	  --for=condition=ready pod \
	  --selector=app.kubernetes.io/component=controller \
	  --timeout=90s

.PHONY: infra-destroy
infra-destroy:
	${INIT}
	${TFCHDIR}${CLUSTER} destroy ${TFOPTS} -auto-approve

.PHONY: app-apply
app-apply:
	kubectl apply -f manifest/namespace.yaml
	sleep 3
	kustomize build manifest | kubectl apply -f -

.PHONY: app-destroy
app-destroy:
	kustomize build manifest | kubectl delete -f -
	kubectl delete -f manifest/namespace.yaml
