#!/bin/bash

# argo cd 삭제
kubectl delete --namespace argocd -f argo-cd.yaml

# 네임스페이스 삭제
kubectl delete namespace argocd