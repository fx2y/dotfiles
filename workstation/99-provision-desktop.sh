#!/usr/bin/env bash

sudo apt update && \
    sudo apt install -y xinit i3

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

sudo apt install -y firefox
sudo snap install bitwarden

TOOLBOX_REPOS="https://download-cf.jetbrains.com/toolbox"
TOOLBOX_VERSION="1.14.5179"

mkdir -p ~/opt
wget --quiet ${TOOLBOX_REPOS}/jetbrains-toolbox-${TOOLBOX_VERSION}.tar.gz -O /tmp/jetbrains-toolbox.tar.gz && \
    tar xzvf /tmp/jetbrains-toolbox.tar.gz > ~/opt/jetbrains-toolbox