#!/bin/bash

apt update -y

adduser --disabled-password --gecos "" adminuser

usermod -aG sudo adminuser

HASHED=$(echo -n "PASSWORD" | openssl passwd -6 -stdin)

echo "adminuser:$HASHED" | chpasswd -e

adduser --disabled-password --gecos "" poweruser

IPT=$(which iptables)
echo "poweruser ALL=(root) NOPASSWD: $IPT" >> /etc/sudoers

sudo setfacl -m u:poweruser:rx /home/adminuser

sudo -u poweruser ln -s /etc/mtab /home/poweruser/mtab_link
