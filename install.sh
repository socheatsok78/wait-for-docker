#!/bin/bash
set -e

curl -L https://github.com/socheatsok78/wait-for-docker/releases/download/v1.5.6/wait-for-docker \
     -o /sbin/wait-for-docker

chmod +x /sbin/wait-for-docker

echo "Installed to /sbin/wait-for-docker"
