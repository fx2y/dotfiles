#!/usr/bin/env bash

. util.sh

sudo dnf config-manager --set-enabled updates-testing
sudo dnf config-manager --set-enabled updates-testing-modular
sudo dnf install -y \
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf upgrade -y

sudo reboot