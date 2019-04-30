#!/usr/bin/env bash

cat <<EOF | sudo tee /etc/apt/sources.list >/dev/null
deb http://deb.debian.org/debian unstable main contrib non-free
deb http://security.debian.org/debian-security/ stable/updates main contrib non-free
deb http://deb.debian.org/debian stable-updates main contrib non-free
EOF

sudo apt update && \
    sudo apt upgrade -y && \
    sudo apt autoremove -y && \
    sudo reboot