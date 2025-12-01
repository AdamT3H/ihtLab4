#!/bin/bash

adduser -s /bin/bash --disabled-password --gecos "" adminuser

usermod -aG sudo adminuser

HASHED=$(echo -n "PASSWORD" | openssl passwd -6 -stdin)

echo "adminuser:$HASHED" | chpasswd -e

adduser -s /bin/bash --gecos "" poweruser
passwd -d poweruser

IPT=$(which iptables)
echo "poweruser ALL=(root) NOPASSWD: $IPT" > /etc/sudoers.d/poweruser

chmod 440 /etc/sudoers.d/poweruser

usermod -aG adminuser poweruser

chmod 750 /home/adminuser

ln -s /etc/mtab /home/poweruser/mtab_link
