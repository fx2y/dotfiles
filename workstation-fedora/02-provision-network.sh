#!/usr/bin/env bash

. util.sh

sudo dnf install -y curl

echo "=== Installing Hosts... ==="
curl https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts | sudo tee /etc/hosts >/dev/null
echo "127.0.0.1 $HOSTNAME" | sudo tee -a /etc/hosts >/dev/null

echo "=== Installing Privoxy... ==="
sudo dnf install -y privoxy
echo 'export http_proxy="http://localhost:8118"' >> ~/.bashrc.local
echo 'export https_proxy="$http_proxy"' >> ~/.bashrc.local

echo "=== Installing DNSCrypt... ==="
sudo dnf install -y dnscrypt-proxy
cat <<EOF | sudo tee /etc/resolv.conf >/dev/null
nameserver 127.0.0.1
options edns0 single-request-reopen
EOF
sudo chattr +i /etc/resolv.conf

sudo reboot