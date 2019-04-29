#!/usr/bin/env bash

sudo apt update

echo "=== Installing Conda... ==="
wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p ~/opt/conda && \
    rm /tmp/miniconda.sh && \
    ~/opt/conda/bin/conda clean -tipsy && \
    echo '. "$HOME/opt/conda/etc/profile.d/conda.sh"' >> ~/.bashrc.local && \
    echo "conda activate base" >> ~/.bashrc.local

echo "=== Installing Jupyter Lab... ==="
conda install jupyterlab