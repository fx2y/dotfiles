#!/usr/bin/env bash

sudo apt update && \
    sudo apt install -y wget

echo "=== Installing Conda... ==="
mkdir -p ~/opt
wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p ~/opt/conda && \
    rm /tmp/miniconda.sh && \
    ~/opt/conda/bin/conda clean -tipsy && \
    echo '. "$HOME/opt/conda/etc/profile.d/conda.sh"' >> ~/.bashrc.local && \
    echo "conda activate base" >> ~/.bashrc.local
. "$HOME/opt/conda/etc/profile.d/conda.sh"
conda activate base

echo "=== Installing Jupyter Lab... ==="
conda install -y jupyterlab