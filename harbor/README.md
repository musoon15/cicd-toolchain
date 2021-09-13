# Harbor - Helm Chart v1.7.1
## 설치 준비
### Harbor v2.3.1 이미지 다운로드
```
docker login harbor.gantry.ai

docker pull harbor.gantry.ai/cicd/goharbor/harbor-exporter:v2.3.1
docker pull harbor.gantry.ai/cicd/goharbor/chartmuseum-photon:v2.3.1
docker pull harbor.gantry.ai/cicd/goharbor/redis-photon:v2.3.1
docker pull harbor.gantry.ai/cicd/goharbor/trivy-adapter-photon:v2.3.1
docker pull harbor.gantry.ai/cicd/goharbor/notary-server-photon:v2.3.1
docker pull harbor.gantry.ai/cicd/goharbor/notary-signer-photon:v2.3.1
docker pull harbor.gantry.ai/cicd/goharbor/harbor-registryctl:v2.3.1
docker pull harbor.gantry.ai/cicd/goharbor/registry-photon:v2.3.1
docker pull harbor.gantry.ai/cicd/goharbor/nginx-photon:v2.3.1
docker pull harbor.gantry.ai/cicd/goharbor/harbor-jobservice:v2.3.1
docker pull harbor.gantry.ai/cicd/goharbor/harbor-core:v2.3.1
docker pull harbor.gantry.ai/cicd/goharbor/harbor-portal:v2.3.1
docker pull harbor.gantry.ai/cicd/goharbor/harbor-db:v2.3.1
```
또는
```
wget https://github.com/goharbor/harbor/releases/download/v2.3.1/harbor-offline-installer-v2.3.1.tgz
mkdir temp
tar -zxvf harbor-offline-installer-v2.3.1.tgz -C temp/
docker load -i temp/harbor/harbor.v2.3.1.tar.gz
```
### Harbor 이미지 레지스트리 이름 변경
```
docker tag harbor.gantry.ai/cicd/goharbor/harbor-exporter:v2.3.1 <IP>:<PORT>/goharbor/harbor-exporter:v2.3.1
docker tag harbor.gantry.ai/cicd/goharbor/chartmuseum-photon:v2.3.1 <IP>:<PORT>/goharbor/chartmuseum-photon:v2.3.1
docker tag harbor.gantry.ai/cicd/goharbor/redis-photon:v2.3.1 <IP>:<PORT>/goharbor/redis-photon:v2.3.1
docker tag harbor.gantry.ai/cicd/goharbor/trivy-adapter-photon:v2.3.1 <IP>:<PORT>/goharbor/trivy-adapter-photon:v2.3.1
docker tag harbor.gantry.ai/cicd/goharbor/notary-server-photon:v2.3.1 <IP>:<PORT>/goharbor/notary-server-photon:v2.3.1
docker tag harbor.gantry.ai/cicd/goharbor/notary-signer-photon:v2.3.1 <IP>:<PORT>/goharbor/notary-signer-photon:v2.3.1
docker tag harbor.gantry.ai/cicd/goharbor/harbor-registryctl:v2.3.1 <IP>:<PORT>/goharbor/harbor-registryctl:v2.3.1
docker tag harbor.gantry.ai/cicd/goharbor/registry-photon:v2.3.1 <IP>:<PORT>/goharbor/registry-photon:v2.3.1
docker tag harbor.gantry.ai/cicd/goharbor/nginx-photon:v2.3.1 <IP>:<PORT>/goharbor/nginx-photon:v2.3.1
docker tag harbor.gantry.ai/cicd/goharbor/harbor-jobservice:v2.3.1 <IP>:<PORT>/goharbor/harbor-jobservice:v2.3.1
docker tag harbor.gantry.ai/cicd/goharbor/harbor-core:v2.3.1 <IP>:<PORT>/goharbor/harbor-core:v2.3.1
docker tag harbor.gantry.ai/cicd/goharbor/harbor-portal:v2.3.1 <IP>:<PORT>/goharbor/harbor-portal:v2.3.1
docker tag harbor.gantry.ai/cicd/goharbor/harbor-db:v2.3.1 <IP>:<PORT>/goharbor/harbor-db:v2.3.1
```
### Harbor 이미지 푸시
```
docker push <IP>:<PORT>/goharbor/harbor-exporter:v2.3.1
docker push <IP>:<PORT>/goharbor/chartmuseum-photon:v2.3.1
docker push <IP>:<PORT>/goharbor/redis-photon:v2.3.1
docker push <IP>:<PORT>/goharbor/trivy-adapter-photon:v2.3.1
docker push <IP>:<PORT>/goharbor/notary-server-photon:v2.3.1
docker push <IP>:<PORT>/goharbor/notary-signer-photon:v2.3.1
docker push <IP>:<PORT>/goharbor/harbor-registryctl:v2.3.1
docker push <IP>:<PORT>/goharbor/registry-photon:v2.3.1
docker push <IP>:<PORT>/goharbor/nginx-photon:v2.3.1
docker push <IP>:<PORT>/goharbor/harbor-jobservice:v2.3.1
docker push <IP>:<PORT>/goharbor/harbor-core:v2.3.1
docker push <IP>:<PORT>/goharbor/harbor-portal:v2.3.1
docker push <IP>:<PORT>/goharbor/harbor-db:v2.3.1
```
### Harbor 차트 values.yaml 수정
```
# values.yaml

# 워커노드 중 하나의 IP를 사용
expose.tls.auto.commonName: <WORKER NODE IP>
expose.externalURL: <WORKER NODE IP>

# harbor.gantry.ai 주소를 내부 registry 주소로 변경
harbor.gantry.ai/goharbor/nginx-photon -> <IP>:<PORT>/goharbor/nginx-photon
```
## 설치
### 설치 스크립트 실행
```
$ ./install.sh
```
### NodePort 설정
```
$ kubectl edit service -n harbor harbor

# service/harbor
spec
  ports:
  - name: https
    nodePort: <NodePort>
  type: NodePort
```
### 자체 서명된 인증서 사용 시 쿠버네티스 적용 방법
```
# harbor-nginx secret의 ca.crt 데이터 복사
$ kubectl get secret -n harbor harbor-nginx -o jsonpath='{.data.ca\.crt}' | base64 -d 

# 워커노드에 접속하여 복사된 데이터를 파일로 생성
$ sudo vi /usr/local/share/ca-certificates/ca.crt

# /etc/ssl/certs 디렉토리를 업데이트하여 SSL 인증서를 보유하고 ca-인증서를 생성
$ sudo update-ca-certificates

# containerd 사용 시 재시작
$ sudo systemctl restart containerd
```
### 제거
```
$ ./uninstall.sh
```