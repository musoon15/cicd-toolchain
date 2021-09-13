#!/bin/bash

# 차트 삭제
helm uninstall jenkins -n jenkins

# 권한 삭제
kubectl delete -f jenkins-clusterrolebinding.yaml
kubectl delete -f jenkins-clusterrole.yaml
kubectl delete -f jenkins-serviceaccount.yaml

# 네임스페이스 삭제
kubectl delete namespace jenkins