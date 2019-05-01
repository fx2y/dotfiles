#!/usr/bin/env bash

. util.sh

sudo dnf remove -y \
    docker \
    docker-client \
    docker-client-latest \
    docker-common \
    docker-latest \
    docker-latest-logrotate \
    docker-logrotate \
    docker-selinux \
    docker-engine-selinux \
    docker-engine

sudo dnf -y install dnf-plugins-core

sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

sudo dnf install docker-ce docker-ce-cli containerd.io

sudo systemctl start docker

sudo docker run hello-world

docker volume ls -q -f driver=nvidia-docker | xargs -r -I{} -n1 docker ps -q -a -f volume={} | xargs -r docker rm -f
sudo yum remove nvidia-docker

#distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
distribution=rhel7
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.repo | \
    sudo tee /etc/yum.repos.d/nvidia-docker.repo

sudo yum install nvidia-docker2
sudo pkill -SIGHUP dockerd