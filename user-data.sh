#!/bin/bash
set -e

useradd -m -s /bin/bash adminuser

PASSWORD=$(openssl rand -base64 16 | tr -d '=')

HASHED=$(openssl passwd -6 "$PASSWORD")

echo "PASSWORD == $PASSWORD" > /tmp/generated_pass.txt

chmod 400 /tmp/generated_pass.txt

echo "adminuser:$HASHED" | chpasswd -e

echo "adminuser ALL=(ALL) ALL" | tee /etc/sudoers.d/adminuser
chmod 440 /etc/sudoers.d/adminuser

usermod -aG sudo adminuser

useradd -m -s /bin/bash poweruser
passwd -d poweruser

IPT=$(which iptables)
echo "poweruser ALL=(root) NOPASSWD: $IPT" > /etc/sudoers.d/poweruser-iptables
chmod 440 /etc/sudoers.d/poweruser-iptables

usermod -aG adminuser poweruser

chmod 750 /home/adminuser

ln -s /etc/mtab /home/poweruser/mtab_link