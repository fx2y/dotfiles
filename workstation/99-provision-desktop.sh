#!/usr/bin/env bash

echo "=== Installing i3 window manager... ==="
sudo apt update && \
    sudo apt install -y xinit i3

echo "=== Configuring i3 window manager... ==="
cp /etc/X11/xinit/xinitrc ~/.xinitrc
cat <<EOF >> ~/.xinitrc
exec /usr/bin/i3
EOF

cat <<EOF > ~/.xserverrc
#!/bin/sh

exec /usr/bin/Xorg -nolisten tcp -nolisten local "\$@" "vt\$XDG_VTNR"
EOF

cat <<EOF >> ~/.bashrc.local
if [[ ! "\$DISPLAY" && "\$XDG_VTNR" -eq 1 ]]; then
  exec startx
fi
EOF

echo "=== Configure terminal environment... ==="
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
~/.bash_it/install.sh --silent
echo 'source "$HOME/.bashrc.local"' >> ~/.bashrc

echo "=== Installing Firefox... ==="
sudo apt install -y firefox

echo "=== Installing Bitwarden... ==="
sudo snap install bitwarden

echo "===Installing GitNote... ==="
GITNOTE_REPOS="https://github.com/zhaopengme/gitnote/releases/download"
GITNOTE_VERSION="3.1.0"
mkdir -p ~/opt
wget --quiet ${GITNOTE_REPOS}/${GITNOTE_VERSION}/GitNote_setup_${GITNOTE_VERSION}.AppImage -O ~/opt/gitnoteapp/GitNote.AppImage

echo "=== Installing Jetbrains Toolbox... ==="
TOOLBOX_REPOS="https://download-cf.jetbrains.com/toolbox"
TOOLBOX_VERSION="1.14.5179"
mkdir -p ~/opt
wget --quiet ${TOOLBOX_REPOS}/jetbrains-toolbox-${TOOLBOX_VERSION}.tar.gz -O /tmp/jetbrains-toolbox.tar.gz && \
    tar xzvf /tmp/jetbrains-toolbox.tar.gz > ~/opt/jetbrains-toolbox && \
    rm /tmp/jetbrains-toolbox.tar.gz