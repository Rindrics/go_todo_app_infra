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

.PHONY: infra-destroy
infra-destroy:
	${INIT}
	${TFCHDIR}${CLUSTER} destroy ${TFOPTS} -auto-approve
