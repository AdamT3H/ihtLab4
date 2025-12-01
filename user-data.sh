#!/bin/bash

adduser -s -m /bin/bash --disabled-password --gecos "" adminuser

usermod -aG sudo adminuser

HASHED=$(echo -n "PASSWORD" | openssl passwd -6 -stdin)

echo "adminuser:$HASHED" | chpasswd -e

echo "adminuser ALL =(ALL:ALL) ALL" | tee /etc/sudoers.d/adminuser
chmod 440 /etc/sudoers.d/adminuser

adduser -s /bin/bash --gecos "" poweruser
passwd -d poweruser

IPT=$(which iptables)
echo "poweruser ALL=(root) NOPASSWD: $IPT" > /etc/sudoers.d/poweruser-iptables
chmod 440 /etc/sudoers.d/poweruser-iptables

usermod -aG adminuser poweruser

chown -R adminuser:adminuser /home/adminuser
chmod 750 /home/adminuser

ln -s /etc/mtab /home/poweruser/mtab_link
