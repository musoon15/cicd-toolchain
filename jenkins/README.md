# Jenkins - Helm Chart v3.5.11

### 설치 준비
```
values.yaml 파일에서 이미지 레지스트리 변경

harbor.gantry.ai/cicd/jenkins/jenkins -> [REGISTRY]/jenkins/jenkins
harbor.gantry.ai/cicd/kiwigrid/k8s-sidecar -> [REGISTRY]/kiwigrid/k8s-sidecar
harbor.gantry.ai/cicd/jenkins/inbound-agent -> [REGISTRY]/jenkins/inbound-agent
```

### 설치
```
$ ./install.sh
```

### Plugins 추가
```
# plugins.tar 파일을 스토리지에 추가
```

### 프라이빗 레지스트리에 접근하기 위한 Secret 생성
```
# 레지스트리 정보 입력 후 실행
$ kubectl create secret docker-registry -n jenkins harbor-cred \
  --docker-server=[REGISTRY] \
  --docker-username=[USER] \
  --docker-password=[PASSWORD]
```

### 자체 서명된 인증서를 사용하는 Harbor에 접근하기 위한 Secret 생성
```
# harbor-nginx secret의 ca.crt 데이터를 additional-ca-cert-bundle.crt 파일로 생성
$ kubectl get secret -n harbor harbor-nginx -o jsonpath='{.data.ca\.crt}' | base64 -d > additional-ca-cert-bundle.crt

# 생성한 additional-ca-cert-bundle.crt 파일을 이용하여 secret 생성
$ kubectl create secret generic -n jenkins registry-cert --from-file=./additional-ca-cert-bundle.crt
```

### 제거
```
$ ./uninstall.sh
```
