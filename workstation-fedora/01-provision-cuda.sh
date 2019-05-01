#!/usr/bin/env bash

. util.sh

ARCH="x86_64"

CUDA_REPOS="https://developer.download.nvidia.com/compute/cuda/repos"
CUDA_LTS_RELEASE="fedora29"
CUDA_VERSION="10.1.105-1"
CUDA_FILENAME="cuda-repo-${CUDA_LTS_RELEASE}-${CUDA_VERSION}.${ARCH}.rpm"
CUDA_URL="$CUDA_REPOS/$CUDA_LTS_RELEASE/$ARCH/$CUDA_FILENAME"

CUDNN_REPOS="https://developer.download.nvidia.com/compute/machine-learning/repos"
CUDNN_LTS_RELEASE="rhel7"
CUDNN_VERSION="1.0.0-1"
CUDNN_FILENAME="nvidia-machine-learning-repo-${CUDNN_LTS_RELEASE}-${CUDNN_VERSION}.${ARCH}.rpm"
CUDNN_URL="$CUDNN_REPOS/$CUDNN_LTS_RELEASE/$ARCH/$CUDNN_FILENAME"

echo "=== Pre-installation Actions... ==="
sudo dnf install -y kernel-devel-$(uname -r) kernel-headers-$(uname -r)

echo "=== Address custom xorg.conf, if applicable... ==="
sudo rm /etc/X11/xorg.conf

echo "=== Satisfy Akmods dependency... ==="
sudo dnf install -y \
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

echo "=== Install repository meta-data... ==="
sudo dnf install -y ${CUDA_URL}

echo "=== Claen DNF repository cache... ==="
sudo dnf clean all

echo "=== Install CUDA... ==="
sudo dnf install -y cuda

echo "=== Add libcuda.so symbolic link, if necessary... ==="

echo "=== Environment setup... ==="
echo 'export PATH=/usr/local/cuda-10.1/bin:/usr/local/cuda-10.1/NsightCompute-2019.1${PATH:+:${PATH}}' >> ~/.bashrc.local
echo 'export LD_LIBRARY_PATH=/usr/local/cuda-10.1/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}' >> ~/.bashrc.local

echo "=== Machine Learning repository... ==="
sudo dnf install ${CUDNN_URL}
sudo dnf install libcudnn7 libcudnn7-devel libnccl libnccl-devel