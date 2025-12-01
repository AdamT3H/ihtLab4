#!/bin/bash

adduser --disabled-password --gecos "" adminuser

usermod -aG sudo adminuser

HASHED=$(echo -n "PASSWORD" | openssl passwd -6 -stdin)

echo "adminuser:$HASHED" | chpasswd -e

adduser --disabled-password --gecos "" poweruser

IPT=$(which iptables)
echo "poweruser ALL=(root) NOPASSWD: $IPT" >> /etc/sudoers

groupadd adminshared
usermod -aG adminshared adminuser
usermod -aG adminshared poweruser

chgrp adminshared /home/adminuser
chmod 750 /home/adminuser

-u poweruser ln -s /etc/mtab /home/poweruser/mtab_link
