#!/usr/bin/env bash

sudo apt update && \
    sudo apt install -y \
        nvidia-cuda-dev \
        nvidia-cuda-toolkit \
        nvidia-driver && \
    sudo apt autoremove -y && \
    sudo reboot