#!/usr/bin/env bash

CUDA_REPOS="https://developer.download.nvidia.com/compute/cuda/repos"
LTS_RELEASE="ubuntu1804"
ARCH="x86_64"
ARCH_NAME="amd64"
CUDA_VERSION="10.1.105-1"
CUDA_FILENAME="cuda-repo-${LTS_RELEASE}_${CUDA_VERSION}_${ARCH_NAME}.deb"
CUDA_URL="$CUDA_REPOS/$LTS_RELEASE/$ARCH/$CUDA_FILENAME"
CUDA_PUBKEY="7fa2af80.pub"
CUDA_PUBKEY_URL="$CUDA_REPOS/$LTS_RELEASE/$ARCH/$CUDA_PUBKEY"

wget --quiet ${CUDA_URL} -O /tmp/${CUDA_FILENAME} && \
    sudo dpkg -i /tmp/${CUDA_FILENAME} && \
    sudo apt-key adv --fetch-keys ${CUDA_PUBKEY_URL} && \
    sudo apt-get update && \
    sudo apt-get install -y cuda

echo 'export PATH="/usr/local/cuda-10.1/bin:/usr/local/cuda-10.1/NsightCompute-2019.1${PATH:+:${PATH}}"' >> ~/.bashrc.local
echo 'export LD_LIBRARY_PATH="/usr/local/cuda-10.1/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"' >> ~/.bashrc.local

sudo reboot