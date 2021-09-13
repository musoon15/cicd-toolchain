#!/bin/bash

# 네임스페이스 생성
kubectl create namespace harbor

# 차트 압축 해제
tar -zxvf harbor-1.7.1.tgz

# 차트 설치
helm install harbor ./harbor/ -n harbor -f values.yaml