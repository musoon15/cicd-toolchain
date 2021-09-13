#!/bin/bash

# 네임스페이스 생성
kubectl create namespace argocd

# 설치
kubectl apply --namespace argocd -f argo-cd.yaml