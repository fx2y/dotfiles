#!/usr/bin/env bash

sudo apt update

echo "=== Installing Node... ==="
sudo apt install -y nodejs

echo "=== Installing Yarn... ==="
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install -y yarn
echo 'export PATH="$PATH:`yarn global bin`"' >> ~/.bashrc.local

echo "=== Installing Prisma... ==="
yarn global add prisma