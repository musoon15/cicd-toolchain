#!/bin/bash

# 차트 삭제
helm uninstall -n harbor harbor

# 네임스페이스 삭제
kubectl delete namespace harbor