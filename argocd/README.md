# Argo CD - v2.1.1

### 설치 준비
```
# argo-cd.yaml 파일에서 이미지 레지스트리 변경

harbor.gantry.ai/cicd/ghcr.io/dexidp/dex:v2.27.0 -> [REGISTRY]/ghcr.io/dexidp/dex:v2.27.0
harbor.gantry.ai/cicd/quay.io/argoproj/argocd:v2.1.1 -> [REGISTRY]/quay.io/argoproj/argocd:v2.1.1
harbor.gantry.ai/cicd/redis:6.2.4-alpine -> [REGISTRY]/redis:6.2.4-alpine
```

### 설치
```
$ ./install.sh
```

### CLI 설정
```
$ mv argocd-linux-amd64 /usr/local/bin/argocd
$ chmod +x /usr/local/bin/argocd
```

### 초기 비밀번호 확인 및 변경
```
# 초기 비밀번호 확인
$ kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

# 로그인
$ argocd login <IP:PORT>
Username: admin
Password: <secret에서 출력된 password>

# 비밀번호 변경
$ argocd account update-password
<Current Password: >
<Change  Password: >
<Change  Password: >
```

### 제거
```
$ ./uninstall.sh
```
