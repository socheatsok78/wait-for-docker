# wait-for-docker
Rancher CLI helper for waiting for Docker service to start.

### Install

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/socheatsok78/wait-for-docker/master/install.sh)"
```

### Example

```yml
#cloud-config

write_files:
  - path: /etc/rc.local
    permissions: "0755"
    owner: root
    content: |
      #!/bin/bash
      wait-for-docker
      
      export curlimage=appropriate/curl
      export jqimage=stedolan/jq
      export rancher_version=v2.2.2
      
      for image in $curlimage $jqimage "rancher/rancher:${rancher_version}"; do
        until docker inspect $image > /dev/null 2>&1; do
          docker pull $image
          sleep 2
        done
      done
      
      docker run -d --restart=unless-stopped -p 80:80 -p 443:443 -v /opt/rancher:/var/lib/rancher rancher/rancher:${rancher_version}
```

or alternatively:

```sh
#!/bin/bash
curl https://raw.githubusercontent.com/socheatsok78/wait-for-docker/master/install.sh | /bin/bash -s
wait-for-docker

docker pull portainer/portainer-ce
docker volume create portainer_data
docker run -d \
  -p 8000:8000 \
  -p 9000:9000 \
  --name=portainer \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  portainer/portainer-ce
```
