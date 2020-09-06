# wait-for-docker
Rancher CLI helper for waiting for Docker service to start.

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
