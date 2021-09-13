#!/bin/bash

# 네임스페이스 생성
kubectl create namespace jenkins

# 권한 생성
kubectl apply -f jenkins-serviceaccount.yaml
kubectl apply -f jenkins-clusterrole.yaml
kubectl apply -f jenkins-clusterrolebinding.yaml

# 차트 압축 풀기
tar -xvzf jenkins-3.5.11.tgz

# 차트 설치
helm install jenkins ./jenkins/ -n jenkins --version 3.5.11 -f values.yaml 